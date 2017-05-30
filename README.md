
![](prompt.png)

# prompt

Dynamic Prompt. The idea is to leverage `addTaskCallback` to update the prompt 
dynamically, e.g. 

```{ r eval = FALSE}
set_prompt( ~ "{h}> " )
set_prompt( ~ "{w}> " )
set_prompt( ~ "{m} {t} {w}> ")
```

You can use `expand_prompt` to experiment : 

```{r}
expand_prompt( ~ "{h}> " )
expand_prompt( ~ "{w}> " )
expand_prompt( ~ "{m} {t} {w}> ")
```



![](example.png)

in a way that can be configured. Things we might want to display: 

- current time
- memory used `pryr::mem_used`
- current working directory, maybe slightly differently when it's not the directory of the current rstudio project
- are we developping a package ? Do we need to rebuild it ? 
- are we sync with github
- R version
- ...
- (please add your own with PR)

## Installation

```
install_github( "ThinkRstat/prompt" )
```

## Usage

```r
library(prompt)
```

## License

MIT + file LICENSE © 
