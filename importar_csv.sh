#!/bin/bash
PSQL="psql postgres://lethereal:E7GPui3DBngk@ep-lively-meadow-217791-pooler.us-west-2.aws.neon.tech/filateste -t --no-align -c"

CLIP1() {
  VIDEO_ID=$($PSQL "SELECT video_id FROM videos WHERE video_id = '$ID_PASTA'")
  if [[ -z $VIDEO_ID ]]
    #Se o vídeo não existe
    then
      echo "$($PSQL "INSERT INTO videos(fonte, video_id, codigo, tipo_audio, imagem, audio, ultimo_teste, op_vt, op_audio) VALUES('$1', '$2', '$3', '$4', '$5', '$6', to_date('$7', 'dd/mm/yyyy'), '$8', '$9')")"
    #Video existe
  fi
}

cat Fila-de-Teste.csv | while IFS=";" read FONTE ID_PASTA CODIGO_NOME DURACAO TIPO_AUDIO IMAGEM AUDIO ULTIMO_TESTE OP_VT OP_AUDIO
do
  if [[ $FONTE != 'Fonte' ]]
    then

      if [[ $FONTE == 'CLIP1' ]]
        then
          CLIP1 "$FONTE" "$ID_PASTA" "$CODIGO_NOME" "$DURACAO" "$TIPO_AUDIO" "$IMAGEM" "$AUDIO" "$ULTIMO_TESTE" "$OP_VT" "$OP_AUDIO"
      #elif
        #then
        #Tratamento CLIP2
      #else
        #Tratamento INFOWS
      fi

  fi
done
