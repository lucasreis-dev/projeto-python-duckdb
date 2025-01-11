FROM python:3.9-slim

# Instala dependências do sistema
RUN apt-get update && apt-get install -y \
    gcc \
    libffi-dev \
    && rm -rf /var/lib/apt/lists/*

# Instala o Poetry
RUN curl -sSL https://install.python-poetry.org | python3 -

# Adiciona o Poetry ao PATH
ENV PATH="${PATH}:${HOME}/.local/bin"

# Copia o código-fonte
COPY . /src
WORKDIR /src

# Instala as dependências do projeto
RUN poetry install

# Expõe a porta e define o ponto de entrada
EXPOSE 8501
ENTRYPOINT ["poetry", "run", "streamlit", "run", "app.py"]