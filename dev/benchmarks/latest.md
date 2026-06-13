## Minecraft load time benchmark

---

<p align="center" style="font-size:160%;">
MC total load time:<br>
249 sec
<br>
<sup><sub>(
4:09 min
)</sub></sup>
</p>

<br>
<!--
Note for image scripts:
  - Newlines are ignored
  - This characters cant be used: +<"%#
-->
<p align="center">
<img alt="Loading Timeline" src="https://quickchart.io/chart.png?w=400&h=60&c={
  type: 'horizontalBar',
  data: {
    datasets: [
        {label: 'Mixins\n', data: [28.00]},
        {label: 'Construction\n', data: [51.00]},
        {label: 'PreInit\n', data: [120.00]},
        {label: 'Init\n', data: [47.00]},
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
          value: 28,
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
<img alt="Mods Loading Time" src="https://quickchart.io/chart.png?w=400&h=300&c={
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
436e17  8.42s Had Enough Items;
395E14  5.13s [JEI Plugins];
5161a8  6.91s CraftTweaker2;
8f304e  5.76s Astral Sorcery;
6a3eba  5.25s Ender IO CEu;
5A359E  1.38s [VF ModelBake];
a651a8  4.56s IndustrialCraft 2;
213664  3.97s Forestry;
1C2E55  1.25s [VF ModelBake];
cd922c  3.69s NuclearCraft;
176e6e  3.14s Recurrent Complex Volts;
813e81  3.36s OpenComputers;
3e68ba  2.44s AE2 Unofficial Extended Life;
35589E  0.65s [VF ModelBake];
306e8f  2.07s Custom Loading Screen;
ba3eb8  2.04s Cyclic;
436e17  2.03s Integrated Dynamics;
3e8160  2.02s The Twilight Forest;
308f7e  2.01s Quark: RotN Edition;
216364  1.85s Thermal Expansion;
444444 26.59s 18 Other mods;
333333 46.25s 148 'Fast' mods (1.0s - 0.1s);
222222  8.34s 318 'Instant' mods (%3C 0.1s)
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
<img alt="Loader Steps" src="https://quickchart.io/chart.png?w=400&h=450&c={
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
CraftTweaker2                 | 0.13| 0.00| 2.63| 4.09| 0.00| 0.06| 0.00| 0.00;
Astral Sorcery                | 0.14| 0.00| 4.67| 0.96| 0.00| 0.00| 0.00| 0.00;
Ender IO CEu                  | 0.67| 0.01| 1.71| 0.15| 1.32| 0.00| 0.01| 1.38;
IndustrialCraft 2             | 0.68| 0.01| 3.15| 0.72| 0.00| 0.00| 0.00| 0.00;
Forestry                      | 0.24| 0.01| 1.80| 0.68| 0.00| 0.00| 0.00| 1.25;
NuclearCraft                  | 0.04| 0.01| 2.76| 0.86| 0.00| 0.00| 0.03| 0.00;
Recurrent Complex Volts       | 0.14| 0.00| 0.24| 2.76| 0.00| 0.00| 0.00| 0.00;
OpenComputers                 | 0.10| 0.01| 1.12| 1.31| 0.05| 0.00| 0.00| 0.39;
AE2 Unofficial Extended Life  | 0.06| 0.01| 1.24| 0.49| 0.01| 0.00| 0.00| 0.65;
Custom Loading Screen         | 2.07| 0.00| 0.00| 0.00| 0.00| 0.00| 0.00| 0.00;
[Mod Average]                 | 0.06| 0.00| 0.14| 0.07| 0.00| 0.00| 0.00| 0.01
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
<img alt="TOP JEI Registered Plugis" src="https://quickchart.io/chart.png?w=500&h=200&c={
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
 0.70: jeresources.jei.JEIConfig;
 0.65: com.buuz135.industrial.jei.JEICustomPlugin;
 0.45: crazypants.enderio.machines.integration.jei.MachinesPlugin;
 0.44: mezz.jei.plugins.vanilla.VanillaPlugin;
 0.43: com.rwtema.extrautils2.crafting.jei.XUJEIPlugin;
 0.32: ic2.jeiIntegration.SubModule;
 0.16: cofh.thermalexpansion.plugins.jei.JEIPluginTE;
 0.15: com.buuz135.thaumicjei.ThaumcraftJEIPlugin;
 0.14: knightminer.tcomplement.plugin.jei.JEIPlugin;
 0.11: crazypants.enderio.base.integration.jei.JeiPlugin;
 0.08: ninjabrain.gendustryjei.GendustryJEIPlugin;
 0.07: thaumicenergistics.integration.jei.ThEJEI;
 1.42: Other
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
<img alt="FML Stuff" src="https://quickchart.io/chart.png?w=500&h=400&c={
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
            text: '100.25s',
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
994400  1.60s Reloading;
002C99  3.01s Loading Resource - AssetLibrary;
2C9900  3.44s Preloading 53386 textures;
229900  1.80s Texture loading;
009911  5.29s Posting bake events;
00991C 28.58s Setting up dynamic models;
009926 28.64s Loading Resource - ModelManager;
00998C 29.36s Rendering Setup;
4F0099  1.09s XML Recipes;
590099  1.73s InterModComms;
990036 10.50s [VintageFix]: Texture search 70921 sprites;
99002C  3.64s Preloaded 33796 sprites
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
