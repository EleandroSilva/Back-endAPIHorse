{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{            In�cio do projeto 24/04/2024               }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2023                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit View.Swagger.Condicao.Pagamento;

interface

uses
  Horse.GBSwagger,
  Entidade.Swagger.Condicao.Pagamento;
type
  TSwaggerCondicaoPagamento = class
   private
   public
     class procedure SwaggerCondicaoPagamento;
  end;

implementation

{ TSwaggerCondicaoPagamento }

class procedure TSwaggerCondicaoPagamento.SwaggerCondicaoPagamento;
begin
  Swagger
    .Path('condicao-pagamento')//nome do meu Path
      .Tag('condicao-pagamento')//agrupando meus Endpoint Tag do Path condicao-pagamento
        .GET('Listar todos', 'Listo todos os condicao-pagamentos')
          .AddResponse(201, 'lista dos condicao-pagamento encontrada com sucesso!')//Aqui passo a resposta do Path
            .Schema(TCondicaoPagamento)//A resposta seria do objeto condicao-pagamento
            .IsArray(True)//Como � um GET ALL passo um Array=True
      .&End
          .AddResponse(400).&End
          .AddResponse(404).&End
          .AddResponse(500).&End
    .&End
    .POST('Adicionar um novo condicao-pagamento!')
      .AddParamBody('Dados do condicao-pagamento')
        .Schema(TCondicaoPagamento)
      .&End
          .AddResponse(201)
          .Schema(TCondicaoPagamento)
        .&End
          .AddResponse(400).&End
          .AddResponse(404).&End
          .AddResponse(500).&End
      .&End
    .&End
    .Path('condicao-pagamento/{id}')
      .Tag('condicao-pagamento')
        .GET('encontrar condi��o de pagamento por id')
          .AddParamPath('id', 'Id do condicao-pagamento')
            .Schema(SWAG_INTEGER)
          .&End
          .AddResponse(201, 'Registro encontrada com sucesso!').&End
          .AddResponse(400).&End//erro de valida��o
          .AddResponse(404).&End//id inv�lido
          .AddResponse(500).&End//erro banco de dados
    .&End
    .PUT('Update condicao-pagamento')
      .AddParamPath('Update condicao-pagamento', 'id do condicao-pagamento')
        .Schema(SWAG_INTEGER)
      .&End
      .AddParamBody('condicao-pagamentoDiario', 'Dados do condicao-pagamento')
        .Schema(TCondicaoPagamento)
      .&End
      .AddResponse(204,'Altera��o realizada com sucesso!').&End//sucesso na altera��o
      .AddResponse(400).&End//erro de valida��o
      .AddResponse(404).&End//id inv�lido
      .AddResponse(500).&End//erro banco
    .&End
    .DELETE('Delete condicao-pagamento')
      .AddParamPath('id', 'id do condicao-pagamento')
        .Schema(SWAG_INTEGER)
    .&End
      .AddResponse(204,'Registro exclu�do com sucesso!').&End//sucesso na exclus�o
      .AddResponse(400).&End//erro de valida��o
      .AddResponse(404).&End//id inv�lido
      .AddResponse(500).&End//erro banco
    .&End
    .&End
    .&End
    .Path('condicao-pagamento?nomeusuario')
      .Tag('condicao-pagamento')
        .GET('encontrar condicao-pagamento por Nome usu�rio')
          .AddParamQuery('nomeusuario','Nome usu�rio')
          .Schema(SWAG_STRING)
          .&End
          .AddResponse(201, 'Registro encontrada com sucesso!').&End
          .AddResponse(400).&End//erro de valida��o
          .AddResponse(404).&End//id inv�lido
          .AddResponse(500).&End//erro banco de dados
    .&End;
end;

end.
