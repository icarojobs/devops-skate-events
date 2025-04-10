CREATE USER IF NOT EXISTS 'sail'@'%' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON devops_skate_events.* TO 'sail'@'%';
FLUSH PRIVILEGES;
