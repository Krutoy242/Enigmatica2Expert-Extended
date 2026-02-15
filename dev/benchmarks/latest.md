## Minecraft load time benchmark

---

<p align="center" style="font-size:160%;">
MC total load time:<br>
271 sec
<br>
<sup><sub>(
4:31 min
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
        {label: 'Mixins\n', data: [32.00]},
        {label: 'Construction\n', data: [59.00]},
        {label: 'PreInit\n', data: [121.00]},
        {label: 'Init\n', data: [56.00]},
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
          value: 32,
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
436e17  8.06s Had Enough Items;
395E14  1.39s [JEI Ingredient Filter];
395E14  8.07s [JEI Plugins];
5161a8  6.97s CraftTweaker2;
8f304e  6.13s Astral Sorcery;
516fa8  6.03s Ender IO;
a651a8  4.90s IndustrialCraft 2;
6e5e17  4.73s Tinkers' Antique;
5E5014  3.00s [TCon Textures];
cd922c  3.47s NuclearCraft;
216364  3.11s Xaero's Minimap;
6e175e  3.07s Recurrent Complex;
813e81  2.93s OpenComputers;
213664  2.85s Forestry;
ba3eb8  2.18s Cyclic;
216364  2.18s Thermal Expansion;
308f7e  2.17s Quark: RotN Edition;
436e17  2.14s Integrated Dynamics;
306e8f  2.01s Custom Loading Screen;
444444 29.99s 20 Other mods;
333333 46.31s 144 'Fast' mods (1.0s - 0.1s);
222222  8.31s 306 'Instant' mods (%3C 0.1s)
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
CraftTweaker2                 | 0.13| 0.00| 2.66| 4.14| 0.00| 0.04| 0.00| 0.00;
Astral Sorcery                | 0.20| 0.00| 4.93| 0.99| 0.00| 0.00| 0.00| 0.00;
Ender IO                      | 1.40| 0.01| 2.69| 0.30| 1.61| 0.00| 0.03| 0.00;
IndustrialCraft 2             | 0.89| 0.01| 3.29| 0.72| 0.00| 0.00| 0.00| 0.00;
Tinkers' Antique              | 0.75| 0.01| 0.11| 0.87| 0.00| 0.00| 0.00| 3.00;
NuclearCraft                  | 0.05| 0.01| 2.63| 0.76| 0.00| 0.00| 0.03| 0.00;
Xaero's Minimap               | 0.10| 0.00| 0.04| 2.97| 0.00| 0.00| 0.00| 0.00;
Recurrent Complex             | 0.18| 0.00| 0.28| 2.61| 0.00| 0.00| 0.00| 0.00;
OpenComputers                 | 0.14| 0.01| 1.31| 1.42| 0.06| 0.00| 0.00| 0.00;
Forestry                      | 0.29| 0.01| 1.90| 0.65| 0.00| 0.00| 0.00| 0.00;
[Mod Average]                 | 0.06| 0.00| 0.15| 0.08| 0.00| 0.00| 0.00| 0.01
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
 1.78: li.cil.oc.integration.jei.ModPluginOpenComputers;
 0.82: jeresources.jei.JEIConfig;
 0.77: com.buuz135.industrial.jei.JEICustomPlugin;
 0.76: com.rwtema.extrautils2.crafting.jei.XUJEIPlugin;
 0.46: crazypants.enderio.machines.integration.jei.MachinesPlugin;
 0.45: mezz.jei.plugins.vanilla.VanillaPlugin;
 0.45: ic2.jeiIntegration.SubModule;
 0.33: crazypants.enderio.base.integration.jei.JeiPlugin;
 0.15: cofh.thermalexpansion.plugins.jei.JEIPluginTE;
 0.15: knightminer.tcomplement.plugin.jei.JEIPlugin;
 0.15: com.buuz135.thaumicjei.ThaumcraftJEIPlugin;
 0.13: rustic.compat.jei.RusticJEIPlugin;
 1.68: Other
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
            text: '111.92s',
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
994400  1.42s Reloading;
001799  3.16s Loading Resource - AssetLibrary;
179900  3.54s Preloading 51413 textures;
0D9900  2.09s Texture loading;
009911  1.26s Texture mipmap and upload;
009926  4.09s Posting bake events;
009930 28.09s Setting up dynamic models;
00993A 28.15s Loading Resource - ModelManager;
009299 28.88s Rendering Setup;
590099  1.57s XML Recipes;
630099  2.07s InterModComms;
990073 10.21s [VintageFix]: Texture search 69981 sprites;
990069  3.62s Preloaded 33665 sprites
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
