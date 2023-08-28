#!/usr/bin/env python
import os
import pickle
from argparse import ArgumentParser, Namespace
from typing import List


def arguments() -> Namespace:
    parser = ArgumentParser()
    parser.add_argument(
        "-d",
        "--data_dir",
        help="data directory",
        type=str,
    )
    parser.add_argument(
        "-k",
        "--key_dir",
        help="key directory",
        type=str,
    )
    parser.add_argument(
        "--train_key_file",
        type=str,
        required=True,
    )
    parser.add_argument(
        "--validate_key_file",
        type=str,
        required=True,
    )
    parser.add_argument(
        "--test_key_file",
        type=str,
        required=True,
    )
    # parser.add_argument(
    #     "--train",
    #     action="store_true",
    #     help="generate train keys",
    # )
    args, _ = parser.parse_known_args()
    return args


def write_keys(keys: List[str], file: str) -> None:
    with open(file, "wb") as w:
        pickle.dump(keys, w)
    return


def main(args: Namespace) -> None:
    keys = os.listdir(args.data_dir)
    with open(args.train_key_file, "r") as f:
        train_keys = [line.split()[0] for line in f.readlines()]
    with open(args.validate_key_file, "r") as f:
        validate_keys = [line.split()[0] for line in f.readlines()]
    with open(args.test_key_file, "r") as f:
        test_keys = [line.split()[0] for line in f.readlines()]

    train_keys = [key for key in keys if key.split('_')[0] in train_keys]
    validate_keys = [key for key in keys if key.split('_')[0] in validate_keys]
    test_keys = [key for key in keys if key.split('_')[0] in test_keys]

    write_keys(train_keys, os.path.join(args.key_dir, "train_keys.pkl"))
    write_keys(validate_keys, os.path.join(args.key_dir, "validate_keys.pkl"))
    write_keys(test_keys, os.path.join(args.key_dir, "test_keys.pkl"))
    return


if __name__ == "__main__":
    args = arguments()
    if not os.path.exists(args.key_dir):
        os.mkdir(args.key_dir)
    main(args)
