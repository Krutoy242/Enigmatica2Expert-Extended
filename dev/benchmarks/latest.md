## Minecraft load time benchmark

---

<p align="center" style="font-size:160%;">
MC total load time:<br>
242 sec
<br>
<sup><sub>(
4:02 min
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
        {label: 'Mixins\n', data: [29.00]},
        {label: 'Construction\n', data: [49.00]},
        {label: 'PreInit\n', data: [118.00]},
        {label: 'Init\n', data: [43.00]},
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
          value: 29,
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
436e17  8.22s Had Enough Items;
395E14  5.41s [JEI Plugins];
516fa8  6.92s Ender IO;
455E8F  1.64s [VF ModelBake];
8f304e  6.07s Astral Sorcery;
5161a8  5.06s CraftTweaker2;
a651a8  4.76s IndustrialCraft 2;
213664  3.78s Forestry;
1C2E55  1.03s [VF ModelBake];
cd922c  3.31s NuclearCraft;
813e81  3.35s OpenComputers;
6e175e  2.87s Recurrent Complex;
3e68ba  2.60s AE2 Unofficial Extended Life;
35589E  0.61s [VF ModelBake];
308f7e  2.05s Quark: RotN Edition;
ba3eb8  2.03s Cyclic;
436e17  1.94s Integrated Dynamics;
216364  1.88s Thermal Expansion;
306e8f  1.84s Custom Loading Screen;
a86e51  1.91s Extra Utilities 2;
444444 24.07s 17 Other mods;
333333 45.28s 144 'Fast' mods (1.0s - 0.1s);
222222  8.55s 321 'Instant' mods (%3C 0.1s)
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
Ender IO                      | 1.25| 0.01| 2.47| 0.28| 1.26| 0.00| 0.01| 1.64;
Astral Sorcery                | 0.16| 0.00| 4.91| 0.99| 0.00| 0.00| 0.00| 0.00;
CraftTweaker2                 | 0.08| 0.00| 2.92| 2.06| 0.00| 0.00| 0.00| 0.00;
IndustrialCraft 2             | 0.77| 0.01| 3.32| 0.67| 0.00| 0.00| 0.00| 0.00;
Forestry                      | 0.26| 0.01| 1.90| 0.59| 0.00| 0.00| 0.00| 1.03;
NuclearCraft                  | 0.04| 0.01| 2.46| 0.77| 0.00| 0.00| 0.03| 0.00;
OpenComputers                 | 0.12| 0.01| 1.22| 1.43| 0.04| 0.00| 0.00| 0.27;
Recurrent Complex             | 0.14| 0.00| 0.35| 2.38| 0.00| 0.00| 0.00| 0.00;
AE2 Unofficial Extended Life  | 0.07| 0.01| 1.26| 0.65| 0.01| 0.00| 0.00| 0.61;
Quark: RotN Edition           | 0.02| 0.01| 1.94| 0.09| 0.00| 0.00| 0.00| 0.00;
[Mod Average]                 | 0.06| 0.00| 0.14| 0.06| 0.00| 0.00| 0.00| 0.01
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
 0.75: jeresources.jei.JEIConfig;
 0.54: mezz.jei.plugins.vanilla.VanillaPlugin;
 0.51: ic2.jeiIntegration.SubModule;
 0.46: crazypants.enderio.machines.integration.jei.MachinesPlugin;
 0.38: com.buuz135.industrial.jei.JEICustomPlugin;
 0.34: com.rwtema.extrautils2.crafting.jei.XUJEIPlugin;
 0.30: knightminer.tcomplement.plugin.jei.JEIPlugin;
 0.21: crazypants.enderio.base.integration.jei.JeiPlugin;
 0.17: cofh.thermalexpansion.plugins.jei.JEIPluginTE;
 0.13: com.buuz135.thaumicjei.ThaumcraftJEIPlugin;
 0.12: thaumicenergistics.integration.jei.ThEJEI;
 0.09: ninjabrain.gendustryjei.GendustryJEIPlugin;
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
            text: '96.88s',
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
994400  1.41s Reloading;
002299  3.12s Loading Resource - AssetLibrary;
2C9900  3.11s Preloading 53299 textures;
229900  1.53s Texture loading;
009911  4.96s Posting bake events;
00991C 27.20s Setting up dynamic models;
009926 27.26s Loading Resource - ModelManager;
00998C 27.97s Rendering Setup;
440099  1.21s XML Recipes;
4F0099  1.64s InterModComms;
005F99 10.09s [VintageFix]: Texture search 69881 sprites;
005599  3.22s Preloaded 33709 sprites
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
