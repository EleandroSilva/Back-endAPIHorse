{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{            In�cio do projeto 17/04/2024               }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit View.Swagger.Categoria.Produto;

interface

uses
  Horse.GBSwagger,
  Entidade.Swagger.Categoria.Produto;
type
  TSwaggerCategoriaProduto = class
   private
   public
     class procedure SwaggerCategoriaProduto;
  end;

implementation

{ TSwaggerCategoriaProduto }

class procedure TSwaggerCategoriaProduto.SwaggerCategoriaProduto;
begin

  Swagger
    .Path('categoria-produto')//nome do meu Path
      .Tag('Categoria do produto')//agrupando meus Endpoint Tag do Path categoriaproduto
        .GET('Listar todos', 'Listo todas as categorias dos produtos')
          .AddResponse(201, 'lista de todas categorias dos produtos encontrada com sucesso!')//Aqui passo a resposta do Path
            .Schema(TCategoriaProduto)//A resposta seria do objeto categoriaproduto
            .IsArray(True)//Como � um GET ALL passo um Array=True
      .&End
          .AddResponse(400).&End
          .AddResponse(404).&End
          .AddResponse(500).&End
    .&End
    .POST('Adicionar uma nova categoria de produto!')
      .AddParamBody('Dados da categoria dos produtos')
        .Schema(TCategoriaProduto)
      .&End
          .AddResponse(201)
          .Schema(TCategoriaProduto)
        .&End
          .AddResponse(400).&End
          .AddResponse(404).&End
          .AddResponse(500).&End
      .&End
    .&End
    .Path('categoria-produto/{id}')
      .Tag('Categoria do produto')
        .GET('encontrar categoria do produto por id')
          .AddParamPath('id', 'Id da categoria do produto')
            .Schema(SWAG_INTEGER)
          .&End
          .AddResponse(201).&End
          .AddResponse(400).&End//erro de valida��o
          .AddResponse(404).&End//id inv�lido
          .AddResponse(500).&End//erro banco de dados
    .&End
    .PUT('Update categoriaproduto')
      .AddParamPath('Update categoriaproduto', 'id da categoria do produto')
        .Schema(SWAG_INTEGER)
      .&End
      .AddParamBody('categoriaproduto', 'Dados da categoria do produto')
        .Schema(TCategoriaProduto)
      .&End
      .AddResponse(204,'Altera��o realizada com sucesso!').&End//sucesso na altera��o
      .AddResponse(400).&End//erro de valida��o
      .AddResponse(404).&End//id inv�lido
      .AddResponse(500).&End//erro banco
    .&End
    .DELETE('Delete categoriaproduto')
      .AddParamPath('id', 'id da categoria do produto')
        .Schema(SWAG_INTEGER)
    .&End
      .AddResponse(204,'Exclus�o realizada com sucesso!').&End//sucesso na exclus�o
      .AddResponse(400).&End//erro de valida��o
      .AddResponse(404).&End//id inv�lido
      .AddResponse(500).&End//erro banco
    .&End
    .&End
    .Path('categoria-produto?nomecategoria')
      .Tag('Categoria do produto')
        .GET('encontrar categoria do produto pelo nome da categoria')
          .AddParamQuery('nomecategoria', 'Nome da categoria do produto a ser filtrado')//, TSwagStringFormat.FormatString);
           .Schema(SWAG_STRING)
          .&End
          .AddResponse(201, 'Registro encontrado com sucesso!').&End
          .AddResponse(400).&End//erro de valida��o
          .AddResponse(404).&End//id inv�lido
          .AddResponse(500).&End//erro banco de dados
    .&End;
end;

end.
