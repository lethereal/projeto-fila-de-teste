#!/bin/bash
source database-auth.sh

resultEcho() {
  if [[ "$4" == "INSERT 0 1" ]]
    then
      echo "$1 | $3 ($2) inserido com sucesso"
    else
      echo "Falha na inserção do vídeo $1 | $2 | $3"
  fi
}

newCLIP1() {
  VIDEO_ID=$($PSQL "SELECT video_id FROM videos WHERE video_id = '$2'")
  if [[ -z "$VIDEO_ID" ]]
    #Se o vídeo não existe
    then
      if [[ "$5" = 'Pendente' || "$6" = 'Pendente' || "$7" = 'Pendente' || "$8" = 'Pendente' || "$9" = 'Pendente' || "${10}" = 'Pendente' ]]
        then
          RESULT="$($PSQL "INSERT INTO videos(fonte, video_id, codigo, duracao) VALUES('$1', '$2', '$3', '$4')")"
        else
          RESULT="$($PSQL "INSERT INTO videos(fonte, video_id, codigo, duracao, tipo_audio, imagem, audio, ultimo_teste, op_vt, op_audio, observacoes) VALUES('$1', '$2', '$3', '$4', '$5', '$6', '$7', to_date('$ULTIMO_TESTE', 'dd/mm/yyyy'), '$9', '${10}', '${11}')")"
      fi
      resultEcho "$1" "$2" "$3" "$RESULT"
    #Video existe
  fi
}

newCLIP2-INFOWS() {
  VIDEO_ID=$($PSQL "SELECT video_id FROM videos WHERE pasta = '$2'")
  if [[ -z "$VIDEO_ID" ]]
    #Se o vídeo não existe
    then
      if [[ "$5" = 'Pendente' || "$6" = 'Pendente' || "$7" = 'Pendente' || "$8" = 'Pendente' || "$9" = 'Pendente' || "${10}" = 'Pendente' ]]
        then
          RESULT="$($PSQL "INSERT INTO videos(fonte, pasta, nome, duracao) VALUES('$1', '$2', '$3', '$4')")"
        else
          RESULT="$($PSQL "INSERT INTO videos(fonte, pasta, nome, duracao, tipo_audio, imagem, audio, ultimo_teste, op_vt, op_audio, observacoes) VALUES('$1', '$2', '$3', '$4', '$5', '$6', '$7', to_date('$ULTIMO_TESTE', 'dd/mm/yyyy'), '$9', '${10}', '${11}')")"
      fi
      resultEcho "$1" "$2" "$3" "$RESULT"
    #Video existe
  fi
}

cat Fila-de-Teste.csv | while IFS=";" read -r FONTE ID_PASTA CODIGO_NOME DURACAO TIPO_AUDIO IMAGEM AUDIO ULTIMO_TESTE OP_VT OP_AUDIO OBSERVACOES
do
  if [[ "$FONTE" != 'Fonte' ]]
    then
      case "$FONTE" in
        CLIP1)
          newCLIP1 "$FONTE" "$ID_PASTA" "$CODIGO_NOME" "$DURACAO" "$TIPO_AUDIO" "$IMAGEM" "$AUDIO" "$ULTIMO_TESTE" "$OP_VT" "$OP_AUDIO" "$OBSERVACOES"
          ;;
        
        CLIP2 | INFOWS)
        #Tratamento CLIP2
          newCLIP2-INFOWS "$FONTE" "$ID_PASTA" "$CODIGO_NOME" "$DURACAO" "$TIPO_AUDIO" "$IMAGEM" "$AUDIO" "$ULTIMO_TESTE" "$OP_VT" "$OP_AUDIO" "$OBSERVACOES"
          ;;
        
        *)
          echo "Fonte inválida $1 | $2 | $3"
          ;;
      esac
  fi
done
