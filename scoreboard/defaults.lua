--[[
        Copyright © 2020, SirEdeonX, Akirane
        All rights reserved.

        Redistribution and use in source and binary forms, with or without
        modification, are permitted provided that the following conditions are met:

            * Redistributions of source code must retain the above copyright
              notice, this list of conditions and the following disclaimer.
            * Redistributions in binary form must reproduce the above copyright
              notice, this list of conditions and the following disclaimer in the
              documentation and/or other materials provided with the distribution.
            * Neither the name of xivhotbar nor the
              names of its contributors may be used to endorse or promote products
              derived from this software without specific prior written permission.

        THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
        ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
        WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
        DISCLAIMED. IN NO EVENT SHALL SirEdeonX OR Akirane BE LIABLE FOR ANY
        DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
        (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
        LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
        ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
        (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
        SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
]]

local defaults = {}

-- defaults.Texts = {}
-- defaults.Texts.Exp = {}
-- defaults.Texts.Exp.Pos = {}
-- defaults.Texts.Exp.Pos.X = 159
-- defaults.Texts.Exp.Pos.Y = 13
-- defaults.Texts.Exp.Flags = {}
-- defaults.Texts.Exp.Flags.Right = false
-- defaults.Texts.Exp.Flags.Bottom = false
-- defaults.Texts.Exp.Flags.Bold = false
-- defaults.Texts.Exp.Flags.Draggable = false
-- defaults.Texts.Exp.Flags.Italic = false
-- defaults.Texts.Exp.Padding = 0

defaults.display = {}
defaults.display.pos = {}
defaults.display.pos.x = 500
defaults.display.pos.y = 100
defaults.display.Background = {}
defaults.display.Background.Alpha = 180
defaults.display.Background.Red = 30
defaults.display.Background.Green = 38
defaults.display.Background.Blue = 66
defaults.display.Background.Visible = true
defaults.display.Text = {}
defaults.display.Text.Size = 10
defaults.display.Text.Font = 'Arial'
defaults.display.Text.Alpha = 255
defaults.display.Text.Red = 253
defaults.display.Text.Green = 252
defaults.display.Text.Blue = 250
defaults.display.Text.Stroke = {}
defaults.display.Text.Stroke.Width = 1
defaults.display.Text.Stroke.Alpha = 127
defaults.display.Text.Stroke.Red = 136
defaults.display.Text.Stroke.Green = 97
defaults.display.Text.Stroke.Blue = 18

-- Conventional settings layout
defaults.numplayers = 8
defaults.sbcolor = 204
defaults.showallidps = true
defaults.resetfilters = true
defaults.visible = true
defaults.showfellow = true
defaults.UpdateFrequency = 0.5
defaults.combinepets = true

-- defaults.display = {}
-- defaults.display.pos = {}
-- defaults.display.pos.x = 500
-- defaults.display.pos.y = 100
-- defaults.display.bg = {}
-- defaults.display.bg.alpha = 200
-- defaults.display.bg.red = 0
-- defaults.display.bg.green = 0
-- defaults.display.bg.blue = 0
-- defaults.display.text = {}
-- defaults.display.text.size = 10
-- defaults.display.text.font = {'Ubuntu Mono', 'sans-serif'}
-- defaults.display.text.fonts = {}
-- defaults.display.text.alpha = 255
-- defaults.display.text.red = 255
-- defaults.display.text.green = 255
-- defaults.display.text.blue = 255


return defaults
