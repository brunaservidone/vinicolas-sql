# Banco de Dados de Vinhos, Vinícolas e Regiões

Banco de dados em **MySQL** que organiza vinhos brasileiros por vinícola e por região produtora. O projeto inclui criação das tabelas, dados de exemplo, consulta com `JOIN` e controle de acesso com um usuário de permissões restritas.

## Estrutura

```
Regiao  1 ──── N  Vinicola  1 ──── N  Vinho
```

| Tabela | Principais campos |
|---|---|
| `Regiao` | código, nome, descrição |
| `Vinicola` | código, nome, descrição, telefone, e-mail, região |
| `Vinho` | código, nome, tipo, ano, descrição, vinícola |

As relações são feitas com chaves estrangeiras (`codRegiao` em `Vinicola` e `codVinicola` em `Vinho`).

## Consulta com JOIN

Lista cada vinho com o ano, a vinícola que o produz e a região de origem:

```sql
SELECT
    Vinho.nomeVinho,
    Vinho.anoVinho,
    Vinicola.nomeVinicola,
    Regiao.nomeRegiao
FROM Vinho
INNER JOIN Vinicola ON Vinho.codVinicola = Vinicola.codVinicola
INNER JOIN Regiao ON Vinicola.codRegiao = Regiao.codRegiao;
```

## Controle de acesso

O script cria o usuário `sommelier`, pensado para quem só precisa consultar os vinhos, seguindo o **princípio do menor privilégio**:

- Pode apenas **ler** (`SELECT`) a tabela `Vinho`.
- Na tabela `Vinicola`, pode ler somente as colunas `codVinicola` e `nomeVinicola`, sem acesso a telefone e e-mail.
- Tem limite de **40 consultas por hora**.

> **Atenção:** a senha do usuário no script é apenas um exemplo (`SUA_SENHA_AQUI`). Em um ambiente real, use uma senha forte e nunca a publique no repositório.

## Como executar

1. Abra o MySQL (Workbench ou linha de comando).
2. Execute o arquivo `Somativa2.sql`.
3. Teste a consulta e o acesso com o usuário `sommelier`.

## O que aprendi

- Criação de tabelas com chaves primárias e estrangeiras.
- Inserção de dados e consultas com `INNER JOIN`.
- Criação de usuários e permissões com `GRANT`, inclusive por coluna.
- Noções de segurança em banco de dados: menor privilégio e limite de consultas.

## Ideias de melhoria

- Aumentar o tamanho do campo `emailVinicola` (hoje `VARCHAR(15)`) para `VARCHAR(100)`.
- Usar `AUTO_INCREMENT` nos códigos.
- Adicionar tabela de avaliações ou de uvas.

## Autora

**Bruna Servidone**
