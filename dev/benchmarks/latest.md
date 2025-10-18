## Minecraft load time benchmark

---

<p align="center" style="font-size:160%;">
MC total load time:<br>
303 sec
<br>
<sup><sub>(
5:03 min
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
        {label: 'Mixins\n', data: [34.00]},
        {label: 'Construction\n', data: [73.00]},
        {label: 'PreInit\n', data: [126.00]},
        {label: 'Init\n', data: [67.00]},
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
          value: 34,
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
436e17 11.23s Had Enough Items;
395E14  1.10s [JEI Ingredient Filter];
395E14  9.27s [JEI Plugins];
5161a8  7.15s CraftTweaker2;
8f304e  7.12s Astral Sorcery;
516fa8  6.46s Ender IO;
a651a8  5.17s IndustrialCraft 2;
813e81  5.07s OpenComputers;
6e5e17  4.92s Tinkers' Antique;
5E5014  3.00s [TCon Textures];
61176e  4.56s Ice and Fire;
cd922c  3.63s NuclearCraft;
6e175e  3.42s Recurrent Complex;
213664  3.17s Forestry;
306e8f  2.83s Custom Loading Screen;
8c2ccd  2.67s Immersive Engineering;
436e17  2.28s Integrated Dynamics;
ba3eb8  2.25s Cyclic;
216364  2.24s Thermal Expansion;
444444 35.85s 22 Other mods;
333333 50.09s 159 'Fast' mods (1.0s - 0.1s);
222222  7.69s 284 'Instant' mods (%3C 0.1s)
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
CraftTweaker2                 | 0.11| 0.00| 2.59| 4.40| 0.00| 0.05| 0.00| 0.00;
Astral Sorcery                | 0.22| 0.00| 4.70| 2.20| 0.00| 0.00| 0.00| 0.00;
Ender IO                      | 1.68| 0.01| 3.08| 0.27| 1.40| 0.00| 0.03| 0.00;
IndustrialCraft 2             | 0.81| 0.01| 3.61| 0.74| 0.00| 0.00| 0.00| 0.00;
OpenComputers                 | 0.15| 0.01| 1.71| 3.15| 0.05| 0.00| 0.00| 0.00;
Tinkers' Antique              | 1.07| 0.01| 0.11| 0.74| 0.00| 0.00| 0.00| 3.00;
Ice and Fire                  | 0.38| 0.01| 0.46| 3.72| 0.00| 0.00| 0.00| 0.00;
NuclearCraft                  | 0.05| 0.01| 2.65| 0.89| 0.00| 0.00| 0.03| 0.00;
Recurrent Complex             | 0.16| 0.01| 0.32| 2.92| 0.00| 0.00| 0.00| 0.00;
Forestry                      | 0.25| 0.01| 2.25| 0.67| 0.00| 0.00| 0.00| 0.00;
[Mod Average]                 | 0.07| 0.00| 0.16| 0.10| 0.00| 0.01| 0.00| 0.01
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
 1.71: li.cil.oc.integration.jei.ModPluginOpenComputers;
 1.38: jeresources.jei.JEIConfig;
 0.73: com.rwtema.extrautils2.crafting.jei.XUJEIPlugin;
 0.56: com.buuz135.industrial.jei.JEICustomPlugin;
 0.53: com.github.sokyranthedragon.mia.integrations.jer.JeiJerIntegration$1;
 0.52: mezz.jei.plugins.vanilla.VanillaPlugin;
 0.49: crazypants.enderio.machines.integration.jei.MachinesPlugin;
 0.41: ic2.jeiIntegration.SubModule;
 0.35: knightminer.tcomplement.plugin.jei.JEIPlugin;
 0.32: crafttweaker.mods.jei.JEIAddonPlugin;
 0.18: cofh.thermalexpansion.plugins.jei.JEIPluginTE;
 0.17: crazypants.enderio.base.integration.jei.JeiPlugin;
 1.93: Other
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
            text: '122.24s',
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
994400  1.86s Reloading;
001799  2.85s Loading Resource - AssetLibrary;
229900  3.15s Preloading 50935 textures;
179900  1.75s Texture loading;
009907  1.17s Texture mipmap and upload;
00991C  3.79s Posting bake events;
009926 28.14s Setting up dynamic models;
009930 28.37s Loading Resource - ModelManager;
009996 29.44s Rendering Setup;
440099  1.35s XML Recipes;
4F0099  1.81s InterModComms;
992600  2.26s Loading Resource - TooltipEventHandler;
99007D 10.80s [VintageFix]: Texture search 68468 sprites;
990073  3.21s Preloaded 33187 sprites
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
