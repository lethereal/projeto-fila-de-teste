#!/bin/bash
PSQL="psql 'postgres://lethereal:tzxaGNJ52kDe@us-west-2.aws.neon.tech/filateste'"

CLIP1() {
  VIDEO_ID=$($PSQL "SELECT video_id FROM videos WHERE video_id = '$ID_PASTA'")
  if [[ -z $VIDEO_ID ]]
    #Se o vídeo não existe
    then
      INSERT_RESULT=$($PSQL "INSERT INTO videos(fonte, video_id, codigo, tipo_audio, imagem, audio, ultimate_teste, op_vt, op_audio) VALUES('$FONTE', '$ID_PASTA', '$CODIGO_NOME', '$TIPO_AUDIO', '$IMAGEM', '$AUDIO', to_date('$ULTIMO_TESTE', 'dd/mm/yyyy'), OP_VT, OP_AUDIO)")
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
