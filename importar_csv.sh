#!/bin/bash
PSQL="psql postgres://lethereal:HFP4Qc5zSvij@ep-rough-mode-134797-pooler.us-west-2.aws.neon.tech/filateste -t --no-align -c"

CLIP1() {
  VIDEO_ID=$($PSQL "SELECT video_id FROM videos WHERE video_id = '$2'")

  if [[ -z "$VIDEO_ID" ]]
    #Se o vídeo não existe
    then
      if [[ "$5" = 'Pendente' || "$6" = 'Pendente' || "$7" = 'Pendente' || "$8" = 'Pendente' || "$9" = 'Pendente' || "${10}" = 'Pendente' ]]
        then
          echo "$($PSQL "INSERT INTO videos(fonte, video_id, codigo, duracao) VALUES('$1', '$2', '$3', '$4')")"
        else
          echo "$($PSQL "INSERT INTO videos(fonte, video_id, codigo, duracao, tipo_audio, imagem, audio, ultimo_teste, op_vt, op_audio, observacoes) VALUES('$1', '$2', '$3', '$4', '$5', '$6', '$7', to_date('$ULTIMO_TESTE', 'dd/mm/yyyy'), '$9', '${10}', '${11}')")"
      fi
      echo "$1 | $2 | $3 | $4 | $5 | $6 | $7 | $8 | $9 | ${10} | ${11}"
    #Video existe
  fi
}

cat Fila-de-Teste.csv | while IFS=";" read FONTE ID_PASTA CODIGO_NOME DURACAO TIPO_AUDIO IMAGEM AUDIO ULTIMO_TESTE OP_VT OP_AUDIO OBSERVACOES
do
  if [[ "$FONTE" != 'Fonte' ]]
    then
      if [[ "$FONTE" == "CLIP1" ]]
        then
          CLIP1 "$FONTE" "$ID_PASTA" "$CODIGO_NOME" "$DURACAO" "$TIPO_AUDIO" "$IMAGEM" "$AUDIO" "$ULTIMO_TESTE" "$OP_VT" "$OP_AUDIO" "$OBSERVACOES"
      
      #elif [[ "$FONTE" == "CLIP2" ]]
        #then
        #Tratamento CLIP2
          CLIP2 "$FONTE" "$ID_PASTA" "$CODIGO_NOME" "$DURACAO" "$TIPO_AUDIO" "$IMAGEM" "$AUDIO" "$ULTIMO_TESTE" "$OP_VT" "$OP_AUDIO" "$OBSERVACOES"
      #else
        #Tratamento INFOWS
      fi

  fi
done
