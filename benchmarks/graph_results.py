import numpy as np
import matplotlib.pyplot as plt

# ---------------------------------------------------------------------------
# Dati: speedup (autovettorizzata, vettorizzata a mano, Vekt-vettorizzata)
# ---------------------------------------------------------------------------

speedup_unrolled = {
    "Vector sum":            (20.40, 15.47, 15.08),
    "Dotp":                  (19.93, 15.29, 14.87),
    "Mat reduce rows":       (13.59, 10.32, 9.80),
    "Mat reduce cols":       (1.00, 15.48, 15.14),
    "Matmul 48x48":          (1.30, 20.78, 20.72),
    "Conv1d K=3":            (1.10, 22.97, 22.34),
    "Conv2d K=3x3":          (1.15, 22.05, 19.22),
    "Transpose":             (1.00, 15.77, 15.40),
    "Max-pool-2d W=2x2":     (1.41, 20.68, 20.57),
}

speedup_not_unrolled = {
    "Vector sum":            (15.48, 15.47, 15.07),
    "Dotp":                  (15.23, 15.27, 14.86),
    "Mat reduce rows":       (13.01, 13.68, 12.99),
}

speedup_varianti_matmul = {
    "Matmul (48,48,48)":     (20.78),
    "Matmul (1,1,16)":       (2.82),
    "Matmul (40,40,40)":     (5.15),
}

SERIES_LABELS = ["Autovettorizatore", "Vettorizzazione manuale", "Vekt"]
SERIES_COLORS = ["#82c47f", "#4C72B0", "#DD8452"]

BAR_WIDTH = 0.8       # larghezza di ciascuna colonna dentro il gruppo
INTRA_GAP = 0.05       # spazio tra le colonne dello stesso kernel
INTER_GAP = 1.2       # spazio tra un kernel e il successivo


def plot_grouped_speedup(data: dict, title: str):
    kernels = list(data.keys())
    n_series = len(SERIES_LABELS)

    group_width = n_series * (BAR_WIDTH + INTRA_GAP)
    group_centers = []

    fig, ax = plt.subplots(
        figsize=(max(10, len(kernels) * 1.6), 6),
        constrained_layout=True
    )

    x_cursor = 0.0
    max_value = max(max(values) for values in data.values())

    for kernel in kernels:
        values = data[kernel]
        bar_positions = []

        for i in range(n_series):
            pos = x_cursor + i * (BAR_WIDTH + INTRA_GAP)
            bar_positions.append(pos)

            ax.bar(
                pos,
                values[i],
                width=BAR_WIDTH,
                color=SERIES_COLORS[i],
                edgecolor="black",
                linewidth=0.5,
                label=SERIES_LABELS[i] if kernel == kernels[0] else None,
            )

            # Etichetta sopra la barra
            ax.text(
                pos,
                values[i] + max_value * 0.015,
                f"{values[i]:.2f}x",
                ha="center",
                va="bottom",
                fontsize=7,
                rotation=90,
            )

        group_center = (bar_positions[0] + bar_positions[-1]) / 2
        group_centers.append(group_center)

        x_cursor += group_width + INTER_GAP

    # ------------------------------------------------------------------
    # Assi
    # ------------------------------------------------------------------

    ax.set_xticks(group_centers)
    ax.set_xticklabels(kernels, rotation=30, ha="right")

    ax.set_ylabel("Speedup")
    ax.set_title(title, pad=15)

    # Linea dello speedup 1x
    ax.axhline(
        1.0,
        color="black",
        linewidth=0.8,
        linestyle="--",
        alpha=0.5,
    )

    # Spazio sufficiente per le etichette sopra le barre
    ax.set_ylim(0, max_value * 1.18)

    # Griglia dietro alle barre
    ax.set_axisbelow(True)
    ax.grid(axis="y", linestyle=":", alpha=0.5)

    # ------------------------------------------------------------------
    # Legenda FUORI dall'area del grafico
    # ------------------------------------------------------------------

    ax.legend(
        title="Versione",
        loc="lower center",
        bbox_to_anchor=(0.5, 1.10),
        ncol=3,
        frameon=True,
    )

    return fig, ax

def plot_simple_speedup(data: dict, title: str):
    kernels = list(data.keys())
    # Estrae il valore singolo sia che sia float sia che sia racchiuso in una tupla
    values = [val[0] if isinstance(val, (tuple, list)) else val for val in data.values()]

    fig, ax = plt.subplots(figsize=(7, 5), constrained_layout=True)

    colors = ["#4C72B0", "#DD8452", "#55A868"]
    max_value = max(values)

    bars = ax.bar(
        kernels,
        values,
        width=0.45,
        color=colors[:len(kernels)],
        edgecolor="black",
        linewidth=0.5
    )

    # Etichette numeriche sopra ogni colonna
    for bar in bars:
        height = bar.get_height()
        ax.text(
            bar.get_x() + bar.get_width() / 2.0,
            height + max_value * 0.02,
            f"{height:.2f}x",
            ha="center",
            va="bottom",
            fontsize=9
        )

    ax.set_ylabel("Speedup")
    ax.set_title(title, pad=15)

    # Linea di riferimento a 1x
    ax.axhline(1.0, color="black", linewidth=0.8, linestyle="--", alpha=0.5)

    ax.set_ylim(0, max_value * 1.18)
    ax.set_axisbelow(True)
    ax.grid(axis="y", linestyle=":", alpha=0.5)

    return fig, ax

if __name__ == "__main__":
    plot_grouped_speedup(speedup_unrolled, "Speedup pattern")
    plot_grouped_speedup(speedup_not_unrolled, "Speedup pattern (senza unrolling)")
    plot_simple_speedup(speedup_varianti_matmul, "Speedup Matmul al variare delle dimensioni (M, N, K)")


    plt.show()

