# PROJETO FINAL DE PÓS GRADUAÇÃO - DEVOPS
Esse é um estudo de caso para implantação de aplicação orquestrada com `Docker Swarm` contendo `4 réplicas`, probe `liveness` e `redness` e também monitoramento com `Prometheus` e `Grafana`.

- Github => [https://github.com/icarojobs/devops-skate-events](https://github.com/icarojobs/devops-skate-events)
---

## SETUP DO DNS
Foi adquirido no serviço `registro.br` do domínio `gestordevalores.com.br` e, apontado os DNS do serviço `cloudflare` para exposição do serviço através de `tunnel`.
Assim, a aplicação fica exposta externamente sem necessáriamente assinar um serviço de hospedagem na nuvem.
Com isso, posso acessar meu computador local (homelab) externamente.
O Homelab está configurado com virtualização bare-metal (proxmox), com 3 containers LXC, sendo:
- 1 container lxc chamado `swarm-manager`
- 1 container lxc chamado `warm-node-1`
- 1 container lxc chamado `warm-node-2`
- 1 container lxc chamado `warm-node-3`

Totalizando `1 manager` e `3 nós`.

- Acesso Externo via Web: [https://sandbox.gestordevalores.com.br](https://sandbox.gestordevalores.com.br)

---
## DEPENDÊNCIAS DOS CONTAINERS APLICAÇÃO EM LOCALHOST
Garanta que você tenha o `docker`, `docker compose`, `git`, `curl` e `make` devidamente instalado e configurado.
Você garantir essas dependências com o seguinte comando:
```bash
# Atualiza repositórios do S.O e instala principais dependências
sudo apt update && sudo apt install git curl make

# Instala o docker:
curl -fsSL https://get.docker.com | sh

# Adiciona o usuário atual ao grupo 'docker'
sudo usermod -aG docker $USER
```

Após garantir que todas as dependências estejam instaladas, basta seguir o seguinte passo a passo:
```bash
# 1. Baixe o projeto do github e navegue no diretório do projeto
git pull https://github.com/icarojobs/devops-skate-events.git
cd devops-skate-events

# 2. Agora, simplesmente execute o comando 'make' dentro do diretório do projeto
make

# 4. Acesse a aplicação, via browser, no endereço http://IP_DO_MANAGER:8000
```
Para ver a aplicação em funcionamento, acesse [https://sandbox.gestordevalores.com.br](https://sandbox.gestordevalores.com.br)

---
## EXECUÇÕES SUBSEQUENTES DO PROJETO
```bash
# Sobe todos os containers (verificar arquivo Makefile):
make up

# Para todos os containers:
make down
```

---
## VERIFICAÇÃO DE E-MAILS
Você pode verificar os e-mails recebidos, em localhost, no endereço [http://localhost:8025](http://localhost:8025)

---
## MONITORAMENTO
Acesse os serviços:
- Prometheus: http://localhost:9090
- Grafana: http://localhost:3000 (usuário: admin, senha: admin) -> Conforme arquivo `.env.example` e `.env`

---

## BUILD DAS IMAGENS
```bash
# Repositório: mob2you/devops-skate-events
# Exemplo: docker push mob2you/devops-skate-events:tagname

# Construindo imagem da aplicação
make build

# ou
docker build -t mob2you/devops-skate-events/sail-8.4-app:latest .

# Enviando imagem construída para docker hub
make push

# ou
docker push mob2you/devops-skate-events:latest
```
---

## DEPLOY NO DOCKER SWARM
Acesse o manager e faça o seguinte:
```bash
# 1. Crie o diretório /docker com as configurações personalizadas
mkdir -p docker/prometheus # mesmas configurações do diretório docker do projeto, no arquivo prometheus.yml

# 2. Copie o arquivo deploy.yml para o 'swarm-manager', em ~/projects/devops-skate-events

# 3. Adicione o arquivo .env na raiz do projeto do 'swarm-manager', em ~/projects/devops-skate-events

# 4. Crie a rede overlay manualmente
docker network create --driver=overlay app_network

# 5. Execute sua stack
docker stack deploy -c deploy.yml devops_skate_events_stack

# Para remover a stack, digite
docker stack rm devops_skate_events_stack
```
