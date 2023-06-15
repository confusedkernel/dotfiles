require'highlight-whitespace'.setup {
        tws = '\\s\\+$',
        clear_on_winleave = false,
        user_palette = {
          markdown = {
            tws = 'RosyBrown',
            ['\\(\\S\\)\\@<=\\s\\(\\.\\|,\\)\\@='] = 'CadetBlue3',
            ['\\(\\S\\)\\@<= \\{2,\\}\\(\\S\\)\\@='] = 'SkyBlue1',

          },
          other = {
            tws = 'PaleVioletRed',
            ['\\(\\S\\)\\@<=\\s\\(,\\)\\@='] = 'coral1',
            ['\\(\\S\\)\\@<= \\{2,\\}\\(\\S\\)\\@='] = 'LightGoldenrod3',

          }
        }
      }
