unit UPrincipal;

interface

uses
     Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
     Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.ExtCtrls,
     Vcl.StdCtrls, Math, System.Actions, Vcl.ActnList;

type
     TfrmPrincipal   =  class(TForm)
          pncontrol: TPanel;
          pnmenu: TPanel;
          btn_sair: TSpeedButton;
          btn_calcular: TSpeedButton;
          Label2: TLabel;
          Label3: TLabel;
          Label4: TLabel;
          Label5: TLabel;
          Label1: TLabel;
          pnresult: TPanel;
          edt_odminicial: TEdit;
          edt_odmfinal: TEdit;
          edt_litros: TEdit;
          edt_preco: TEdit;
          edt_tanque: TEdit;
          lbl: TLabel;
          Label8: TLabel;
          Label9: TLabel;
          Label6: TLabel;
          lbl_kmrodado: TLabel;
          lbl_kmlitro: TLabel;
          lbl_autonomia: TLabel;
          lbl_custo: TLabel;
          Label7: TLabel;
          ActionList1: TActionList;
          act_sair: TAction;
          act_calcular: TAction;
          procedure btn_sairClick(Sender: TObject);
          procedure edt_odminicialKeyPress(Sender: TObject; var Key: Char);
          procedure btn_calcularClick(Sender: TObject);
          procedure FormClose(Sender: TObject; var Action: TCloseAction);
     private
    { Private declarations }
     public
    { Public declarations }
     end;

var
     frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

procedure TfrmPrincipal.edt_odminicialKeyPress(Sender: TObject; var Key: Char);
begin
//VALIDAÇÃO PARA NÃO ENTRAR LETRAS NO EDT
     if not (Key   in  ['0'..'9', ',', '.', #8]) then
     begin
          Key   :=  #0;
          Application.MessageBox('Somente numeros por favor!', 'ERROR', MB_OK   +  MB_ICONSTOP);
     end;
end;

procedure TfrmPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
     Application.Terminate;
end;

procedure TfrmPrincipal.btn_calcularClick(Sender: TObject);
var
     odmInicial, odmFinal, capTanque, kmrodado: Integer;
     precoComb, litroMedia, autonomiaCarro, custo, litroGasto: Double;
begin
     //VALIDAÇÃO PARA PREENCHER TODOS OS DADOS QUANDO APERTAR O CALCULAR
     if edt_odminicial.Text   =  '' then
     begin
          Application.MessageBox('Preencha o campo Odômetro Inicial!', 'ERRO', MB_OK   +  MB_ICONSTOP);
          edt_odminicial.SetFocus;
          Exit
     end;
     if edt_odmfinal.Text   =  '' then
     begin
          Application.MessageBox('Preencha o campo Odômetro Final!', 'ERRO', MB_OK   +  MB_ICONSTOP);
          edt_odmfinal.SetFocus;
          Exit
     end;
     if edt_litros.Text   =  '' then
     begin
          Application.MessageBox('Preencha o campo dos litros gasto na viagem!', 'ERRO', MB_OK   +  MB_ICONSTOP);
          edt_litros.SetFocus;
          Exit
     end;
     if edt_preco.Text   =  '' then
     begin
          Application.MessageBox('Preencha o preço do combustivel!', 'ERRO', MB_OK   +  MB_ICONSTOP);
          edt_preco.SetFocus;
          Exit
     end;
     if edt_tanque.Text   =  '' then
     begin
          Application.MessageBox('Preencha o campo da capacidade do tanque!', 'ERRO', MB_OK   +  MB_ICONSTOP);
          edt_tanque.SetFocus;
          Exit
     end;



     //ATRIBUIR OS EDTS PARA VARIAVEIS
     odmInicial   :=  StrToInt(edt_odminicial.Text);
     odmFinal   :=  StrToInt(edt_odmfinal.Text);
     litroGasto   :=  StrToFloat(edt_litros.Text);
     capTanque   :=  StrToInt(edt_tanque.Text);
     precoComb   :=  StrToFloat(edt_preco.Text);

     //CALCULAR RESULTADOS
     kmrodado   :=  odmFinal   -  odmInicial; //TOTAL DE KM RODADO
     litroMedia   :=  kmrodado   /  litroGasto; //FORMULA KM POR LITRO
     autonomiaCarro   :=  litroMedia   *  capTanque; //QUANTO O CARRO PECORRE COM O TANQUE CHEIO COM A MEDIA CALCULADA ANTERIOMENTE
     custo   :=  precoComb   *  litroGasto; //CUSTO TOTAL DA VIAGEM

     //TORNAR VISIVEL OS LABELS DOS RESULTADOS
     lbl_kmrodado.Visible   :=  True;
     lbl_kmlitro.Visible   :=  True;
     lbl_autonomia.Visible   :=  True;
     lbl_custo.Visible   :=  True;

     //APRESENTAR NOS LABELS OS RESULTADOS
     lbl_kmrodado.Caption   :=  IntToStr(kmrodado)   +  ' KMs';
     lbl_kmlitro.Caption   :=  FloatToStr(RoundTo(litroMedia, -2))   +  '  KM por Litro';
     lbl_autonomia.Caption   :=  FloatToStr(RoundTo(autonomiaCarro, -2))   +  '  KMs pode pecorrer com tanque cheio';
     lbl_custo.Caption   :=  FloatToStr(RoundTo(custo, -2))   +  ' Custo total da viagem';

end;

procedure TfrmPrincipal.btn_sairClick(Sender: TObject);
begin
     if Application.MessageBox('Deseja sair do programa?', 'Sair', MB_YESNO   +  MB_ICONQUESTION)   =  IDYES then
     begin
          Close;
     end;
end;

end.

