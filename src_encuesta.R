
aux <- toupper(letters) %>% expand.grid(p1=., p2=., stringsAsFactors=F) 
aux <- paste0('Escuela ', aux$p1, aux$p2) 
aux <- data.frame(Preparatoria=sample(aux, 234), Encuestados=rpois(234, 6), stringsAsFactors=F)
aux <- aux[sort(aux$Encuestados, decreasing=T, index.return=T)$ix,]
aux$Preparatoria <- factor(aux$Preparatoria, levels = aux$Preparatoria[order(aux$Encuestados)])
tablEscuela <- aux

n_top <- sum(aux$Encuestados[1:30])
n_total <- sum(aux$Encuestados)
t <- paste0('Principales 30 escuelas (representan ', n_top, ' encuestados de ', n_total,')')
chrtEscuela <- rHighcharts:::Chart$new()
chrtEscuela$chart(height=900, type = "bar")
chrtEscuela$plotOptions(column = list(stacking = "normal"))
chrtEscuela$title(text = paste0('Principales 30 preparatorias (representan ', n_top, ' encuestados de ', n_total,')'))
chrtEscuela$yAxis(title = list(text = "Encuestados"))
chrtEscuela$xAxis(categories = head(aux, 30)$Preparatoria)
chrtEscuela$data(head(aux, 30)$Encuestados)
chrtEscuela$legend(enabled = FALSE)