python3 make_blocks.py CAU C B greedy CB 0.01
python3 nemo.py ./CB/nemo.CAU.txt ./CB/glid.CAU.txt ./CB/freqs.CAU.csv 1e-7
python3 impute_GL.py ./CB/pull.CAU.txt ./CB/glid.CAU.txt ./CB/freqs.CAU.csv ./CB/impute.CAU.csv.gz 0.99 1000
python3 make_blocks.py CAU A C~B greedy ACB 0.01
rm ./CB/impute.CAU.csv.gz
python3 nemo.py ./ACB/nemo.CAU.txt ./ACB/glid.CAU.txt ./ACB/freqs.CAU.csv 1e-7
python3 impute_GL.py ./ACB/pull.CAU.txt ./ACB/glid.CAU.txt ./ACB/freqs.CAU.csv ./ACB/impute.CAU.csv.gz 0.99 1000
python3 make_blocks.py CAU DRB1 DQB1 greedy DRB1DQB1 0.01
python3 nemo.py ./DRB1DQB1/nemo.CAU.txt ./DRB1DQB1/glid.CAU.txt ./DRB1DQB1/freqs.CAU.csv 1e-7
python3 impute_GL.py ./DRB1DQB1/pull.CAU.txt ./DRB1DQB1/glid.CAU.txt ./DRB1DQB1/freqs.CAU.csv ./DRB1DQB1/impute.CAU.csv.gz 0.99 1000
python3 make_blocks.py CAU A~C~B DRB1~DQB1 greedy ACBDRB1DQB1 0.01
rm ./ACB/impute.CAU.csv.gz
rm ./DRB1DQB1/impute.CAU.csv.gz
python3 nemo.py ./ACBDRB1DQB1/nemo.CAU.txt ./ACBDRB1DQB1/glid.CAU.txt ./ACBDRB1DQB1/freqs.CAU.csv 1e-7
python3 impute_GL.py ./ACBDRB1DQB1/pull.CAU.txt ./ACBDRB1DQB1/glid.CAU.txt ./ACBDRB1DQB1/freqs.CAU.csv ./ACBDRB1DQB1/impute.CAU.csv.gz 0.99 1000
python3 make_blocks.py AAFA_CARB C B greedy CB 0.01
python3 nemo.py ./CB/nemo.AAFA_CARB.txt ./CB/glid.AAFA_CARB.txt ./CB/freqs.AAFA_CARB.csv 1e-7
python3 impute_GL.py ./CB/pull.AAFA_CARB.txt ./CB/glid.AAFA_CARB.txt ./CB/freqs.AAFA_CARB.csv ./CB/impute.AAFA_CARB.csv.gz 0.99 1000
python3 make_blocks.py AAFA_CARB A C~B greedy ACB 0.01
rm ./CB/impute.AAFA_CARB.csv.gz
python3 nemo.py ./ACB/nemo.AAFA_CARB.txt ./ACB/glid.AAFA_CARB.txt ./ACB/freqs.AAFA_CARB.csv 1e-7
python3 impute_GL.py ./ACB/pull.AAFA_CARB.txt ./ACB/glid.AAFA_CARB.txt ./ACB/freqs.AAFA_CARB.csv ./ACB/impute.AAFA_CARB.csv.gz 0.99 1000
python3 make_blocks.py AAFA_CARB DRB1 DQB1 greedy DRB1DQB1 0.01
python3 nemo.py ./DRB1DQB1/nemo.AAFA_CARB.txt ./DRB1DQB1/glid.AAFA_CARB.txt ./DRB1DQB1/freqs.AAFA_CARB.csv 1e-7
python3 impute_GL.py ./DRB1DQB1/pull.AAFA_CARB.txt ./DRB1DQB1/glid.AAFA_CARB.txt ./DRB1DQB1/freqs.AAFA_CARB.csv ./DRB1DQB1/impute.AAFA_CARB.csv.gz 0.99 1000
python3 make_blocks.py AAFA_CARB A~C~B DRB1~DQB1 greedy ACBDRB1DQB1 0.01
rm ./ACB/impute.AAFA_CARB.csv.gz
rm ./DRB1DQB1/impute.AAFA_CARB.csv.gz
python3 nemo.py ./ACBDRB1DQB1/nemo.AAFA_CARB.txt ./ACBDRB1DQB1/glid.AAFA_CARB.txt ./ACBDRB1DQB1/freqs.AAFA_CARB.csv 1e-7
python3 impute_GL.py ./ACBDRB1DQB1/pull.AAFA_CARB.txt ./ACBDRB1DQB1/glid.AAFA_CARB.txt ./ACBDRB1DQB1/freqs.AAFA_CARB.csv ./ACBDRB1DQB1/impute.AAFA_CARB.csv.gz 0.99 1000
python3 make_blocks.py AAFA_NAMER C B greedy CB 0.01
python3 nemo.py ./CB/nemo.AAFA_NAMER.txt ./CB/glid.AAFA_NAMER.txt ./CB/freqs.AAFA_NAMER.csv 1e-7
python3 impute_GL.py ./CB/pull.AAFA_NAMER.txt ./CB/glid.AAFA_NAMER.txt ./CB/freqs.AAFA_NAMER.csv ./CB/impute.AAFA_NAMER.csv.gz 0.99 1000
python3 make_blocks.py AAFA_NAMER A C~B greedy ACB 0.01
rm ./CB/impute.AAFA_NAMER.csv.gz
python3 nemo.py ./ACB/nemo.AAFA_NAMER.txt ./ACB/glid.AAFA_NAMER.txt ./ACB/freqs.AAFA_NAMER.csv 1e-7
python3 impute_GL.py ./ACB/pull.AAFA_NAMER.txt ./ACB/glid.AAFA_NAMER.txt ./ACB/freqs.AAFA_NAMER.csv ./ACB/impute.AAFA_NAMER.csv.gz 0.99 1000
python3 make_blocks.py AAFA_NAMER DRB1 DQB1 greedy DRB1DQB1 0.01
python3 nemo.py ./DRB1DQB1/nemo.AAFA_NAMER.txt ./DRB1DQB1/glid.AAFA_NAMER.txt ./DRB1DQB1/freqs.AAFA_NAMER.csv 1e-7
python3 impute_GL.py ./DRB1DQB1/pull.AAFA_NAMER.txt ./DRB1DQB1/glid.AAFA_NAMER.txt ./DRB1DQB1/freqs.AAFA_NAMER.csv ./DRB1DQB1/impute.AAFA_NAMER.csv.gz 0.99 1000
python3 make_blocks.py AAFA_NAMER A~C~B DRB1~DQB1 greedy ACBDRB1DQB1 0.01
rm ./ACB/impute.AAFA_NAMER.csv.gz
rm ./DRB1DQB1/impute.AAFA_NAMER.csv.gz
python3 nemo.py ./ACBDRB1DQB1/nemo.AAFA_NAMER.txt ./ACBDRB1DQB1/glid.AAFA_NAMER.txt ./ACBDRB1DQB1/freqs.AAFA_NAMER.csv 1e-7
python3 impute_GL.py ./ACBDRB1DQB1/pull.AAFA_NAMER.txt ./ACBDRB1DQB1/glid.AAFA_NAMER.txt ./ACBDRB1DQB1/freqs.AAFA_NAMER.csv ./ACBDRB1DQB1/impute.AAFA_NAMER.csv.gz 0.99 1000
python3 make_blocks.py FILII_NAMER C B greedy CB 0.01
python3 nemo.py ./CB/nemo.FILII_NAMER.txt ./CB/glid.FILII_NAMER.txt ./CB/freqs.FILII_NAMER.csv 1e-7
python3 impute_GL.py ./CB/pull.FILII_NAMER.txt ./CB/glid.FILII_NAMER.txt ./CB/freqs.FILII_NAMER.csv ./CB/impute.FILII_NAMER.csv.gz 0.99 1000
python3 make_blocks.py FILII_NAMER A C~B greedy ACB 0.01
rm ./CB/impute.FILII_NAMER.csv.gz
python3 nemo.py ./ACB/nemo.FILII_NAMER.txt ./ACB/glid.FILII_NAMER.txt ./ACB/freqs.FILII_NAMER.csv 1e-7
python3 impute_GL.py ./ACB/pull.FILII_NAMER.txt ./ACB/glid.FILII_NAMER.txt ./ACB/freqs.FILII_NAMER.csv ./ACB/impute.FILII_NAMER.csv.gz 0.99 1000
python3 make_blocks.py FILII_NAMER DRB1 DQB1 greedy DRB1DQB1 0.01
python3 nemo.py ./DRB1DQB1/nemo.FILII_NAMER.txt ./DRB1DQB1/glid.FILII_NAMER.txt ./DRB1DQB1/freqs.FILII_NAMER.csv 1e-7
python3 impute_GL.py ./DRB1DQB1/pull.FILII_NAMER.txt ./DRB1DQB1/glid.FILII_NAMER.txt ./DRB1DQB1/freqs.FILII_NAMER.csv ./DRB1DQB1/impute.FILII_NAMER.csv.gz 0.99 1000
python3 make_blocks.py FILII_NAMER A~C~B DRB1~DQB1 greedy ACBDRB1DQB1 0.01
rm ./ACB/impute.FILII_NAMER.csv.gz
rm ./DRB1DQB1/impute.FILII_NAMER.csv.gz
python3 nemo.py ./ACBDRB1DQB1/nemo.FILII_NAMER.txt ./ACBDRB1DQB1/glid.FILII_NAMER.txt ./ACBDRB1DQB1/freqs.FILII_NAMER.csv 1e-7
python3 impute_GL.py ./ACBDRB1DQB1/pull.FILII_NAMER.txt ./ACBDRB1DQB1/glid.FILII_NAMER.txt ./ACBDRB1DQB1/freqs.FILII_NAMER.csv ./ACBDRB1DQB1/impute.FILII_NAMER.csv.gz 0.99 1000
python3 make_blocks.py MENAFC_NAMER C B greedy CB 0.01
python3 nemo.py ./CB/nemo.MENAFC_NAMER.txt ./CB/glid.MENAFC_NAMER.txt ./CB/freqs.MENAFC_NAMER.csv 1e-7
python3 impute_GL.py ./CB/pull.MENAFC_NAMER.txt ./CB/glid.MENAFC_NAMER.txt ./CB/freqs.MENAFC_NAMER.csv ./CB/impute.MENAFC_NAMER.csv.gz 0.99 1000
python3 make_blocks.py MENAFC_NAMER A C~B greedy ACB 0.01
rm ./CB/impute.MENAFC_NAMER.csv.gz
python3 nemo.py ./ACB/nemo.MENAFC_NAMER.txt ./ACB/glid.MENAFC_NAMER.txt ./ACB/freqs.MENAFC_NAMER.csv 1e-7
python3 impute_GL.py ./ACB/pull.MENAFC_NAMER.txt ./ACB/glid.MENAFC_NAMER.txt ./ACB/freqs.MENAFC_NAMER.csv ./ACB/impute.MENAFC_NAMER.csv.gz 0.99 1000
python3 make_blocks.py MENAFC_NAMER DRB1 DQB1 greedy DRB1DQB1 0.01
python3 nemo.py ./DRB1DQB1/nemo.MENAFC_NAMER.txt ./DRB1DQB1/glid.MENAFC_NAMER.txt ./DRB1DQB1/freqs.MENAFC_NAMER.csv 1e-7
python3 impute_GL.py ./DRB1DQB1/pull.MENAFC_NAMER.txt ./DRB1DQB1/glid.MENAFC_NAMER.txt ./DRB1DQB1/freqs.MENAFC_NAMER.csv ./DRB1DQB1/impute.MENAFC_NAMER.csv.gz 0.99 1000
python3 make_blocks.py MENAFC_NAMER A~C~B DRB1~DQB1 greedy ACBDRB1DQB1 0.01
rm ./ACB/impute.MENAFC_NAMER.csv.gz
rm ./DRB1DQB1/impute.MENAFC_NAMER.csv.gz
python3 nemo.py ./ACBDRB1DQB1/nemo.MENAFC_NAMER.txt ./ACBDRB1DQB1/glid.MENAFC_NAMER.txt ./ACBDRB1DQB1/freqs.MENAFC_NAMER.csv 1e-7
python3 impute_GL.py ./ACBDRB1DQB1/pull.MENAFC_NAMER.txt ./ACBDRB1DQB1/glid.MENAFC_NAMER.txt ./ACBDRB1DQB1/freqs.MENAFC_NAMER.csv ./ACBDRB1DQB1/impute.MENAFC_NAMER.csv.gz 0.99 1000
python3 make_blocks.py AAFA_CARB_3000 C B greedy CB 0.01
python3 nemo.py ./CB/nemo.AAFA_CARB_3000.txt ./CB/glid.AAFA_CARB_3000.txt ./CB/freqs.AAFA_CARB_3000.csv 1e-7
python3 impute_GL.py ./CB/pull.AAFA_CARB_3000.txt ./CB/glid.AAFA_CARB_3000.txt ./CB/freqs.AAFA_CARB_3000.csv ./CB/impute.AAFA_CARB_3000.csv.gz 0.99 1000
python3 make_blocks.py AAFA_CARB_3000 A C~B greedy ACB 0.01
rm ./CB/impute.AAFA_CARB_3000.csv.gz
python3 nemo.py ./ACB/nemo.AAFA_CARB_3000.txt ./ACB/glid.AAFA_CARB_3000.txt ./ACB/freqs.AAFA_CARB_3000.csv 1e-7
python3 impute_GL.py ./ACB/pull.AAFA_CARB_3000.txt ./ACB/glid.AAFA_CARB_3000.txt ./ACB/freqs.AAFA_CARB_3000.csv ./ACB/impute.AAFA_CARB_3000.csv.gz 0.99 1000
python3 make_blocks.py AAFA_CARB_3000 DRB1 DQB1 greedy DRB1DQB1 0.01
python3 nemo.py ./DRB1DQB1/nemo.AAFA_CARB_3000.txt ./DRB1DQB1/glid.AAFA_CARB_3000.txt ./DRB1DQB1/freqs.AAFA_CARB_3000.csv 1e-7
python3 impute_GL.py ./DRB1DQB1/pull.AAFA_CARB_3000.txt ./DRB1DQB1/glid.AAFA_CARB_3000.txt ./DRB1DQB1/freqs.AAFA_CARB_3000.csv ./DRB1DQB1/impute.AAFA_CARB_3000.csv.gz 0.99 1000
python3 make_blocks.py AAFA_CARB_3000 A~C~B DRB1~DQB1 greedy ACBDRB1DQB1 0.01
rm ./ACB/impute.AAFA_CARB_3000.csv.gz
rm ./DRB1DQB1/impute.AAFA_CARB_3000.csv.gz
python3 nemo.py ./ACBDRB1DQB1/nemo.AAFA_CARB_3000.txt ./ACBDRB1DQB1/glid.AAFA_CARB_3000.txt ./ACBDRB1DQB1/freqs.AAFA_CARB_3000.csv 1e-7
python3 impute_GL.py ./ACBDRB1DQB1/pull.AAFA_CARB_3000.txt ./ACBDRB1DQB1/glid.AAFA_CARB_3000.txt ./ACBDRB1DQB1/freqs.AAFA_CARB_3000.csv ./ACBDRB1DQB1/impute.AAFA_CARB_3000.csv.gz 0.99 1000
python3 make_blocks.py AAFA_NAMER_3000 C B greedy CB 0.01
python3 nemo.py ./CB/nemo.AAFA_NAMER_3000.txt ./CB/glid.AAFA_NAMER_3000.txt ./CB/freqs.AAFA_NAMER_3000.csv 1e-7
python3 impute_GL.py ./CB/pull.AAFA_NAMER_3000.txt ./CB/glid.AAFA_NAMER_3000.txt ./CB/freqs.AAFA_NAMER_3000.csv ./CB/impute.AAFA_NAMER_3000.csv.gz 0.99 1000
python3 make_blocks.py AAFA_NAMER_3000 A C~B greedy ACB 0.01
rm ./CB/impute.AAFA_NAMER_3000.csv.gz
python3 nemo.py ./ACB/nemo.AAFA_NAMER_3000.txt ./ACB/glid.AAFA_NAMER_3000.txt ./ACB/freqs.AAFA_NAMER_3000.csv 1e-7
python3 impute_GL.py ./ACB/pull.AAFA_NAMER_3000.txt ./ACB/glid.AAFA_NAMER_3000.txt ./ACB/freqs.AAFA_NAMER_3000.csv ./ACB/impute.AAFA_NAMER_3000.csv.gz 0.99 1000
python3 make_blocks.py AAFA_NAMER_3000 DRB1 DQB1 greedy DRB1DQB1 0.01
python3 nemo.py ./DRB1DQB1/nemo.AAFA_NAMER_3000.txt ./DRB1DQB1/glid.AAFA_NAMER_3000.txt ./DRB1DQB1/freqs.AAFA_NAMER_3000.csv 1e-7
python3 impute_GL.py ./DRB1DQB1/pull.AAFA_NAMER_3000.txt ./DRB1DQB1/glid.AAFA_NAMER_3000.txt ./DRB1DQB1/freqs.AAFA_NAMER_3000.csv ./DRB1DQB1/impute.AAFA_NAMER_3000.csv.gz 0.99 1000
python3 make_blocks.py AAFA_NAMER_3000 A~C~B DRB1~DQB1 greedy ACBDRB1DQB1 0.01
rm ./ACB/impute.AAFA_NAMER_3000.csv.gz
rm ./DRB1DQB1/impute.AAFA_NAMER_3000.csv.gz
python3 nemo.py ./ACBDRB1DQB1/nemo.AAFA_NAMER_3000.txt ./ACBDRB1DQB1/glid.AAFA_NAMER_3000.txt ./ACBDRB1DQB1/freqs.AAFA_NAMER_3000.csv 1e-7
python3 impute_GL.py ./ACBDRB1DQB1/pull.AAFA_NAMER_3000.txt ./ACBDRB1DQB1/glid.AAFA_NAMER_3000.txt ./ACBDRB1DQB1/freqs.AAFA_NAMER_3000.csv ./ACBDRB1DQB1/impute.AAFA_NAMER_3000.csv.gz 0.99 1000
python3 make_blocks.py FILII_NAMER_3000 C B greedy CB 0.01
python3 nemo.py ./CB/nemo.FILII_NAMER_3000.txt ./CB/glid.FILII_NAMER_3000.txt ./CB/freqs.FILII_NAMER_3000.csv 1e-7
python3 impute_GL.py ./CB/pull.FILII_NAMER_3000.txt ./CB/glid.FILII_NAMER_3000.txt ./CB/freqs.FILII_NAMER_3000.csv ./CB/impute.FILII_NAMER_3000.csv.gz 0.99 1000
python3 make_blocks.py FILII_NAMER_3000 A C~B greedy ACB 0.01
rm ./CB/impute.FILII_NAMER_3000.csv.gz
python3 nemo.py ./ACB/nemo.FILII_NAMER_3000.txt ./ACB/glid.FILII_NAMER_3000.txt ./ACB/freqs.FILII_NAMER_3000.csv 1e-7
python3 impute_GL.py ./ACB/pull.FILII_NAMER_3000.txt ./ACB/glid.FILII_NAMER_3000.txt ./ACB/freqs.FILII_NAMER_3000.csv ./ACB/impute.FILII_NAMER_3000.csv.gz 0.99 1000
python3 make_blocks.py FILII_NAMER_3000 DRB1 DQB1 greedy DRB1DQB1 0.01
python3 nemo.py ./DRB1DQB1/nemo.FILII_NAMER_3000.txt ./DRB1DQB1/glid.FILII_NAMER_3000.txt ./DRB1DQB1/freqs.FILII_NAMER_3000.csv 1e-7
python3 impute_GL.py ./DRB1DQB1/pull.FILII_NAMER_3000.txt ./DRB1DQB1/glid.FILII_NAMER_3000.txt ./DRB1DQB1/freqs.FILII_NAMER_3000.csv ./DRB1DQB1/impute.FILII_NAMER_3000.csv.gz 0.99 1000
python3 make_blocks.py FILII_NAMER_3000 A~C~B DRB1~DQB1 greedy ACBDRB1DQB1 0.01
rm ./ACB/impute.FILII_NAMER_3000.csv.gz
rm ./DRB1DQB1/impute.FILII_NAMER_3000.csv.gz
python3 nemo.py ./ACBDRB1DQB1/nemo.FILII_NAMER_3000.txt ./ACBDRB1DQB1/glid.FILII_NAMER_3000.txt ./ACBDRB1DQB1/freqs.FILII_NAMER_3000.csv 1e-7
python3 impute_GL.py ./ACBDRB1DQB1/pull.FILII_NAMER_3000.txt ./ACBDRB1DQB1/glid.FILII_NAMER_3000.txt ./ACBDRB1DQB1/freqs.FILII_NAMER_3000.csv ./ACBDRB1DQB1/impute.FILII_NAMER_3000.csv.gz 0.99 1000
python3 make_blocks.py MENAFC_NAMER_3000 C B greedy CB 0.01
python3 nemo.py ./CB/nemo.MENAFC_NAMER_3000.txt ./CB/glid.MENAFC_NAMER_3000.txt ./CB/freqs.MENAFC_NAMER_3000.csv 1e-7
python3 impute_GL.py ./CB/pull.MENAFC_NAMER_3000.txt ./CB/glid.MENAFC_NAMER_3000.txt ./CB/freqs.MENAFC_NAMER_3000.csv ./CB/impute.MENAFC_NAMER_3000.csv.gz 0.99 1000
python3 make_blocks.py MENAFC_NAMER_3000 A C~B greedy ACB 0.01
rm ./CB/impute.MENAFC_NAMER_3000.csv.gz
python3 nemo.py ./ACB/nemo.MENAFC_NAMER_3000.txt ./ACB/glid.MENAFC_NAMER_3000.txt ./ACB/freqs.MENAFC_NAMER_3000.csv 1e-7
python3 impute_GL.py ./ACB/pull.MENAFC_NAMER_3000.txt ./ACB/glid.MENAFC_NAMER_3000.txt ./ACB/freqs.MENAFC_NAMER_3000.csv ./ACB/impute.MENAFC_NAMER_3000.csv.gz 0.99 1000
python3 make_blocks.py MENAFC_NAMER_3000 DRB1 DQB1 greedy DRB1DQB1 0.01
python3 nemo.py ./DRB1DQB1/nemo.MENAFC_NAMER_3000.txt ./DRB1DQB1/glid.MENAFC_NAMER_3000.txt ./DRB1DQB1/freqs.MENAFC_NAMER_3000.csv 1e-7
python3 impute_GL.py ./DRB1DQB1/pull.MENAFC_NAMER_3000.txt ./DRB1DQB1/glid.MENAFC_NAMER_3000.txt ./DRB1DQB1/freqs.MENAFC_NAMER_3000.csv ./DRB1DQB1/impute.MENAFC_NAMER_3000.csv.gz 0.99 1000
python3 make_blocks.py MENAFC_NAMER_3000 A~C~B DRB1~DQB1 greedy ACBDRB1DQB1 0.01
rm ./ACB/impute.MENAFC_NAMER_3000.csv.gz
rm ./DRB1DQB1/impute.MENAFC_NAMER_3000.csv.gz
python3 nemo.py ./ACBDRB1DQB1/nemo.MENAFC_NAMER_3000.txt ./ACBDRB1DQB1/glid.MENAFC_NAMER_3000.txt ./ACBDRB1DQB1/freqs.MENAFC_NAMER_3000.csv 1e-7
python3 impute_GL.py ./ACBDRB1DQB1/pull.MENAFC_NAMER_3000.txt ./ACBDRB1DQB1/glid.MENAFC_NAMER_3000.txt ./ACBDRB1DQB1/freqs.MENAFC_NAMER_3000.csv ./ACBDRB1DQB1/impute.MENAFC_NAMER_3000.csv.gz 0.99 1000
python3 make_blocks.py MR C B greedy CB 0.01
python3 nemo.py ./CB/nemo.MR.txt ./CB/glid.MR.txt ./CB/freqs.MR.csv 1e-7
python3 impute_GL.py ./CB/pull.MR.txt ./CB/glid.MR.txt ./CB/freqs.MR.csv ./CB/impute.MR.csv.gz 0.99 1000
python3 make_blocks.py MR A C~B greedy ACB 0.01
rm ./CB/impute.MR.csv.gz
python3 nemo.py ./ACB/nemo.MR.txt ./ACB/glid.MR.txt ./ACB/freqs.MR.csv 1e-7
python3 impute_GL.py ./ACB/pull.MR.txt ./ACB/glid.MR.txt ./ACB/freqs.MR.csv ./ACB/impute.MR.csv.gz 0.99 1000
python3 make_blocks.py MR DRB1 DQB1 greedy DRB1DQB1 0.01
python3 nemo.py ./DRB1DQB1/nemo.MR.txt ./DRB1DQB1/glid.MR.txt ./DRB1DQB1/freqs.MR.csv 1e-7
python3 impute_GL.py ./DRB1DQB1/pull.MR.txt ./DRB1DQB1/glid.MR.txt ./DRB1DQB1/freqs.MR.csv ./DRB1DQB1/impute.MR.csv.gz 0.99 1000
python3 make_blocks.py MR A~C~B DRB1~DQB1 greedy ACBDRB1DQB1 0.01
rm ./ACB/impute.MR.csv.gz
rm ./DRB1DQB1/impute.MR.csv.gz
python3 nemo.py ./ACBDRB1DQB1/nemo.MR.txt ./ACBDRB1DQB1/glid.MR.txt ./ACBDRB1DQB1/freqs.MR.csv 1e-7
python3 impute_GL.py ./ACBDRB1DQB1/pull.MR.txt ./ACBDRB1DQB1/glid.MR.txt ./ACBDRB1DQB1/freqs.MR.csv ./ACBDRB1DQB1/impute.MR.csv.gz 0.99 1000
python3 make_blocks.py MR_1000 C B greedy CB 0.01
python3 nemo.py ./CB/nemo.MR_1000.txt ./CB/glid.MR_1000.txt ./CB/freqs.MR_1000.csv 1e-7
python3 impute_GL.py ./CB/pull.MR_1000.txt ./CB/glid.MR_1000.txt ./CB/freqs.MR_1000.csv ./CB/impute.MR_1000.csv.gz 0.99 1000
python3 make_blocks.py MR_1000 A C~B greedy ACB 0.01
rm ./CB/impute.MR_1000.csv.gz
python3 nemo.py ./ACB/nemo.MR_1000.txt ./ACB/glid.MR_1000.txt ./ACB/freqs.MR_1000.csv 1e-7
python3 impute_GL.py ./ACB/pull.MR_1000.txt ./ACB/glid.MR_1000.txt ./ACB/freqs.MR_1000.csv ./ACB/impute.MR_1000.csv.gz 0.99 1000
python3 make_blocks.py MR_1000 DRB1 DQB1 greedy DRB1DQB1 0.01
python3 nemo.py ./DRB1DQB1/nemo.MR_1000.txt ./DRB1DQB1/glid.MR_1000.txt ./DRB1DQB1/freqs.MR_1000.csv 1e-7
python3 impute_GL.py ./DRB1DQB1/pull.MR_1000.txt ./DRB1DQB1/glid.MR_1000.txt ./DRB1DQB1/freqs.MR_1000.csv ./DRB1DQB1/impute.MR_1000.csv.gz 0.99 1000
python3 make_blocks.py MR_1000 A~C~B DRB1~DQB1 greedy ACBDRB1DQB1 0.01
rm ./ACB/impute.MR_1000.csv.gz
rm ./DRB1DQB1/impute.MR_1000.csv.gz
python3 nemo.py ./ACBDRB1DQB1/nemo.MR_1000.txt ./ACBDRB1DQB1/glid.MR_1000.txt ./ACBDRB1DQB1/freqs.MR_1000.csv 1e-7
python3 impute_GL.py ./ACBDRB1DQB1/pull.MR_1000.txt ./ACBDRB1DQB1/glid.MR_1000.txt ./ACBDRB1DQB1/freqs.MR_1000.csv ./ACBDRB1DQB1/impute.MR_1000.csv.gz 0.99 1000
python3 make_blocks.py MR_3000 C B greedy CB 0.01
python3 nemo.py ./CB/nemo.MR_3000.txt ./CB/glid.MR_3000.txt ./CB/freqs.MR_3000.csv 1e-7
python3 impute_GL.py ./CB/pull.MR_3000.txt ./CB/glid.MR_3000.txt ./CB/freqs.MR_3000.csv ./CB/impute.MR_3000.csv.gz 0.99 1000
python3 make_blocks.py MR_3000 A C~B greedy ACB 0.01
rm ./CB/impute.MR_3000.csv.gz
python3 nemo.py ./ACB/nemo.MR_3000.txt ./ACB/glid.MR_3000.txt ./ACB/freqs.MR_3000.csv 1e-7
python3 impute_GL.py ./ACB/pull.MR_3000.txt ./ACB/glid.MR_3000.txt ./ACB/freqs.MR_3000.csv ./ACB/impute.MR_3000.csv.gz 0.99 1000
python3 make_blocks.py MR_3000 DRB1 DQB1 greedy DRB1DQB1 0.01
python3 nemo.py ./DRB1DQB1/nemo.MR_3000.txt ./DRB1DQB1/glid.MR_3000.txt ./DRB1DQB1/freqs.MR_3000.csv 1e-7
python3 impute_GL.py ./DRB1DQB1/pull.MR_3000.txt ./DRB1DQB1/glid.MR_3000.txt ./DRB1DQB1/freqs.MR_3000.csv ./DRB1DQB1/impute.MR_3000.csv.gz 0.99 1000
python3 make_blocks.py MR_3000 A~C~B DRB1~DQB1 greedy ACBDRB1DQB1 0.01
rm ./ACB/impute.MR_3000.csv.gz
rm ./DRB1DQB1/impute.MR_3000.csv.gz
python3 nemo.py ./ACBDRB1DQB1/nemo.MR_3000.txt ./ACBDRB1DQB1/glid.MR_3000.txt ./ACBDRB1DQB1/freqs.MR_3000.csv 1e-7
python3 impute_GL.py ./ACBDRB1DQB1/pull.MR_3000.txt ./ACBDRB1DQB1/glid.MR_3000.txt ./ACBDRB1DQB1/freqs.MR_3000.csv ./ACBDRB1DQB1/impute.MR_3000.csv.gz 0.99 1000
python3 make_blocks.py MR_10000 C B greedy CB 0.01
python3 nemo.py ./CB/nemo.MR_10000.txt ./CB/glid.MR_10000.txt ./CB/freqs.MR_10000.csv 1e-7
python3 impute_GL.py ./CB/pull.MR_10000.txt ./CB/glid.MR_10000.txt ./CB/freqs.MR_10000.csv ./CB/impute.MR_10000.csv.gz 0.99 1000
python3 make_blocks.py MR_10000 A C~B greedy ACB 0.01
rm ./CB/impute.MR_10000.csv.gz
python3 nemo.py ./ACB/nemo.MR_10000.txt ./ACB/glid.MR_10000.txt ./ACB/freqs.MR_10000.csv 1e-7
python3 impute_GL.py ./ACB/pull.MR_10000.txt ./ACB/glid.MR_10000.txt ./ACB/freqs.MR_10000.csv ./ACB/impute.MR_10000.csv.gz 0.99 1000
python3 make_blocks.py MR_10000 DRB1 DQB1 greedy DRB1DQB1 0.01
python3 nemo.py ./DRB1DQB1/nemo.MR_10000.txt ./DRB1DQB1/glid.MR_10000.txt ./DRB1DQB1/freqs.MR_10000.csv 1e-7
python3 impute_GL.py ./DRB1DQB1/pull.MR_10000.txt ./DRB1DQB1/glid.MR_10000.txt ./DRB1DQB1/freqs.MR_10000.csv ./DRB1DQB1/impute.MR_10000.csv.gz 0.99 1000
python3 make_blocks.py MR_10000 A~C~B DRB1~DQB1 greedy ACBDRB1DQB1 0.01
rm ./ACB/impute.MR_10000.csv.gz
rm ./DRB1DQB1/impute.MR_10000.csv.gz
python3 nemo.py ./ACBDRB1DQB1/nemo.MR_10000.txt ./ACBDRB1DQB1/glid.MR_10000.txt ./ACBDRB1DQB1/freqs.MR_10000.csv 1e-7
python3 impute_GL.py ./ACBDRB1DQB1/pull.MR_10000.txt ./ACBDRB1DQB1/glid.MR_10000.txt ./ACBDRB1DQB1/freqs.MR_10000.csv ./ACBDRB1DQB1/impute.MR_10000.csv.gz 0.99 1000
