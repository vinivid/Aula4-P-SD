## Integrantes do grupo

Vinícius Souza Freitas - 15491959

Ryan Diniz Pereira - 15590907

### Código Morse

A lógica utilizada para a implementação e é bem simples. Existem dois componentes básicos que são as registradoras e o os contadores.

Existem dois contadores e tres registradoras. Uma registradora é utilizada para salvar o tamanho da palavra, outra é utilizada para salvar a representação de uma palavra em binário a ultima é utilizada para lembrar se o processador de símbolos esta ligado.

Os dois contadores tem as seguintes funções: Um deles é um contador que conta até quatro, ele é responsável por controlar duas coisas. A primeira é a registradora dos símbolos em que o valor qu o contador esta sera o index do vetor do símbolo a ser enviado para o processador de símbolos, a outra é checar se a palavra acabou ao comparar o valor contado até o valor dado como o tamanho da palavra, se eles forem iguais ele desabilita o processador e nenhum digito do código é mostrado mais. O clock deste contador e controlado pelo processador de símbolos. Toda vez que ele processa um simbolo ele pede o proximo bit do código até processar a palavra.

Para explicar o segundo contador é mais fácil explicar em conjunto a unidade de processamento de símbolos. Essa unidade recebe como entrada um símbolo e o processa com base no bit recebido. Se for 0 trata como se fosse um ponto se for 1 trata como se fosse uma barra. Esta unidade tem dentro dela um contador interno, o segundo contador, o qual é responsável por contar os segundos necessários para mostrar cada digito do código. Se for um ponto conta até 0.5 s com o led acesso e mais 0.1 s com o led apagado quando acaba o processo do bit o processador pede mais um bit para o clock. A barra funciona de forma análoga contando até 1.5 s com led acesso e 0.1 s com led pagado depois pede o bit.

Por ultimo temos a unidade responsável por coletar a entrada, para cada entrada é associado um valor de tamanho para a registradora de tamanho e uma sequencia de símbolos para a registradora de símbolos.

Com isso foi feito o processamento de uma palavra morse para FPGA.