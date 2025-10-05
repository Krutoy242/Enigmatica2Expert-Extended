## Minecraft load time benchmark

---

<p align="center" style="font-size:160%;">
MC total load time:<br>
307 sec
<br>
<sup><sub>(
5:07 min
)</sub></sup>
</p>

<br>
<!--
Note for image scripts:
  - Newlines are ignored
  - This characters cant be used: +<"%#
-->
<p align="center">
<img src="https://quickchart.io/chart.png?w=400&h=60&c={
  type: 'horizontalBar',
  data: {
    datasets: [
        {label: 'Mixins\n', data: [40.00]},
        {label: 'Construction\n', data: [63.00]},
        {label: 'PreInit\n', data: [143.00]},
        {label: 'Init\n', data: [58.00]},
    ]
  },
  options: {
    layout: { padding: { top: 10 } },
    scales: {
      xAxes: [{display: false, stacked: true}],
      yAxes: [{display: false, stacked: true}],
    },
    elements: {rectangle: {borderWidth: 2}},
    legend: {display: false},
    plugins: {datalabels: {
      color: 'white',
      font: {
        family: 'Consolas',
      },
      formatter: (value, context) =>
        [context.dataset.label, value, 's'].join('')
    }},
    annotation: {
      clip: false,
      annotations: [{
          type: 'line',
          scaleID: 'x-axis-0',
          value: 40,
          borderColor: 'black',
          label: {
            content: 'Window appear',
            fontSize: 8,
            enabled: true,
            xPadding: 8, yPadding: 2,
            yAdjust: -20
          },
        }
      ]
    },
  }
}"/>
</p>

<br>

# Mods Loading Time

<p align="center">
<img src="https://quickchart.io/chart.png?w=400&h=300&c={
  type: 'outlabeledPie',
  options: {
    rotation: Math.PI,
    cutoutPercentage: 25,
    plugins: {
      legend: !1,
      outlabels: {
        stretch: 5,
        padding: 1,
        text: (v,i)=>[
          v.labels[v.dataIndex],' ',
          (v.percent*1000|0)/10,
          String.fromCharCode(37)].join('')
      }
    }
  },
  data: {...
`
436e17  9.47s Had Enough Items;
395E14  1.32s [JEI Ingredient Filter];
395E14  7.93s [JEI Plugins];
8f304e  7.91s Astral Sorcery;
5161a8  7.24s CraftTweaker2;
516fa8  6.74s Ender IO;
a651a8  5.11s IndustrialCraft 2;
cd922c  4.70s NuclearCraft;
813e81  4.37s OpenComputers;
6e5e17  3.73s Tinkers' Antique;
5E5014  2.00s [TCon Textures];
6e175e  3.42s Recurrent Complex;
213664  3.19s Forestry;
306e8f  2.83s Custom Loading Screen;
436e17  2.77s Integrated Dynamics;
308f7e  2.68s Quark: RotN Edition;
a86e51  2.68s Extra Utilities 2;
ba3eb8  2.23s Cyclic;
3e8160  2.18s The Twilight Forest;
444444 39.80s 26 Other mods;
333333 48.36s 152 'Fast' mods (1.0s - 0.1s);
222222  7.76s 286 'Instant' mods (%3C 0.1s)
`
    .split(';').reduce((a, l) => {
      l.match(/(\w{6}) *(\d*\.\d*) ?s (.*)/s)
      .slice(1).map((a, i) => [[String.fromCharCode(35),a].join(''), a,
        a.length > 15 ? a.split(/(?%3C=.{9})\s(?=\S{5})/).join('\n') : a
      ][i])
      .forEach((s, i) =>
        [a.datasets[0].backgroundColor, a.datasets[0].data, a.labels][i].push(s)
      );
      return a
    }, {
      labels: [],
      datasets: [{
        backgroundColor: [],
        data: [],
        borderColor: 'rgba(22,22,22,0.3)',
        borderWidth: 1
      }]
    })
  }
}"/>
</p>

<br>

# Loader steps

Show how much time each mod takes on each game load phase.

JEI/HEI not included, since its load time based on other mods and overal item count.

<p align="center">
<img src="https://quickchart.io/chart.png?w=400&h=450&c={
  options: {
    scales: {
      xAxes: [{stacked: true}],
      yAxes: [{stacked: true}],
    },
    plugins: {
      datalabels: {
        anchor: 'end',
        align: 'top',
        color: 'white',
        backgroundColor: 'rgba(46, 140, 171, 0.6)',
        borderColor: 'rgba(41, 168, 194, 1.0)',
        borderWidth: 0.5,
        borderRadius: 3,
        padding: 0,
        font: {size:10},
        formatter: (v,ctx) =>
          ctx.datasetIndex!=ctx.chart.data.datasets.length-1 ? null
            : [((ctx.chart.data.datasets.reduce((a,b)=>a- -b.data[ctx.dataIndex],0)*10)|0)/10,'s'].join('')
      },
      colorschemes: {
        scheme: 'office.Damask6'
      }
    }
  },
  type: 'bar',
  data: {...(() => {
    let a = { labels: [], datasets: [] };
`
0: Construction;
1: Loading Resources;
2: PreInitialization;
3: Initialization;
4: InterModComms;
5: LoadComplete;
6: ModIdMapping;
7: Other
`
    .split(';')
      .map(l => l.match(/\d: (.*)/).slice(1))
      .forEach(([name]) => a.datasets.push({ label: name, data: [] }));
`
                                  0      1      2      3      4      5      6      7;
Astral Sorcery                | 0.17| 0.00| 6.58| 1.15| 0.00| 0.00| 0.00| 0.00;
CraftTweaker2                 | 0.14| 0.00| 2.51| 4.53| 0.00| 0.06| 0.00| 0.00;
Ender IO                      | 1.41| 0.01| 2.91| 0.27| 2.14| 0.00| 0.01| 0.00;
IndustrialCraft 2             | 1.03| 0.01| 3.33| 0.73| 0.00| 0.00| 0.00| 0.00;
NuclearCraft                  | 0.05| 0.01| 3.63| 0.98| 0.00| 0.00| 0.03| 0.00;
OpenComputers                 | 0.15| 0.01| 2.63| 1.52| 0.05| 0.00| 0.00| 0.00;
Tinkers' Antique              | 0.94| 0.01| 0.13| 0.66| 0.00| 0.00| 0.00| 2.00;
Recurrent Complex             | 0.20| 0.00| 0.38| 2.84| 0.00| 0.00| 0.00| 0.00;
Forestry                      | 0.28| 0.01| 2.10| 0.80| 0.00| 0.00| 0.00| 0.00;
Custom Loading Screen         | 2.83| 0.00| 0.00| 0.00| 0.00| 0.00| 0.00| 0.00;
[Mod Average]                 | 0.07| 0.00| 0.18| 0.08| 0.01| 0.01| 0.00| 0.00
`
    .split(';').slice(1)
      .map(l => l.split('|').map(s => s.trim()))
      .forEach(([name, ...arr], i) => {
        a.labels.push(name);
        arr.forEach((v, j) => a.datasets[j].data[i] = v)
      }); return a
  })()}
}"/>
</p>

<br>

# TOP JEI Registered Plugis

<p align="center">
<img src="https://quickchart.io/chart.png?w=500&h=200&c={
  options: {
    elements: { rectangle: { borderWidth: 1 } },
    legend: false,
    scales: {
      yAxes: [{ ticks: { fontSize: 9, fontFamily: 'Verdana' }}],
    },
  },
  type: 'horizontalBar',
    data: {...(() => {
      let a = {
        labels: [], datasets: [{
          backgroundColor: 'rgba(0, 99, 132, 0.5)',
          borderColor: 'rgb(0, 99, 132)',
          data: []
        }]
      };
`
 1.68: li.cil.oc.integration.jei.ModPluginOpenComputers;
 0.97: jeresources.jei.JEIConfig;
 0.77: com.rwtema.extrautils2.crafting.jei.XUJEIPlugin;
 0.58: com.buuz135.industrial.jei.JEICustomPlugin;
 0.51: crazypants.enderio.machines.integration.jei.MachinesPlugin;
 0.47: mezz.jei.plugins.vanilla.VanillaPlugin;
 0.40: ic2.jeiIntegration.SubModule;
 0.20: rustic.compat.jei.RusticJEIPlugin;
 0.18: knightminer.tcomplement.plugin.jei.JEIPlugin;
 0.17: cofh.thermalexpansion.plugins.jei.JEIPluginTE;
 0.17: crazypants.enderio.base.integration.jei.JeiPlugin;
 0.14: com.buuz135.thaumicjei.ThaumcraftJEIPlugin;
 1.70: Other
`
        .split(';')
        .map(l => l.split(':'))
        .forEach(([time, name]) => {
          a.labels.push(name);
          a.datasets[0].data.push(time)
        })
        ; return a
    })()
  }
}"/>
</p>

<br>

# FML Stuff

Loading bars that usually not related to specific mods.

⚠️ Shows only steps that took 1.0 sec or more.

<p align="center">
<img src="https://quickchart.io/chart.png?w=500&h=400&c={
  options: {
    rotation: Math.PI*1.125,
    cutoutPercentage: 55,
    plugins: {
      legend: !1,
      outlabels: {
        stretch: 5,
        padding: 1,
        text: (v)=>v.labels
      },
      doughnutlabel: {
        labels: [
          {
            text: 'FML stuff:',
            color: 'rgba(128, 128, 128, 0.5)',
            font: {size: 18}
          },
          {
            text: '128.82s',
            color: 'rgba(128, 128, 128, 1)',
            font: {size: 22}
          }
        ]
      },
    }
  },
  type: 'outlabeledPie',
  data: {...(() => {
    let a = {
      labels: [],
      datasets: [{
        backgroundColor: [],
        data: [],
        borderColor: 'rgba(22,22,22,0.3)',
        borderWidth: 2
      }]
    };
`
000D99  4.43s Loading Resource - AssetLibrary;
179900  3.15s Preloading 51456 textures;
0D9900  1.38s Texture loading;
009911  1.07s Texture mipmap and upload;
009926  4.13s Posting bake events;
009930 30.61s Setting up dynamic models;
00993A 30.68s Loading Resource - ModelManager;
009299 31.96s Rendering Setup;
300099  1.30s File;
4F0099  2.09s XML Recipes;
590099  2.55s InterModComms;
99007D 13.57s [VintageFix]: Texture search 69577 sprites;
990073  3.19s Preloaded 33708 sprites
`
    .split(';')
      .map(l => l.match(/(\w{6}) *(\d*\.\d*) ?s (.*)/s))
      .forEach(([, col, time, name]) => {
        a.labels.push([
          name.length > 15 ? name.split(/(?%3C=.{11})\s(?=\S{6})/).join('\n') : name
          , ' ', time, 's'
        ].join(''));
        a.datasets[0].data.push(parseFloat(time));
        a.datasets[0].backgroundColor.push([String.fromCharCode(35), col].join(''))
      })
      ; return a
  })()}
}"/>
</p>
