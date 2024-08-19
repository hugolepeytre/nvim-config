"""Run either forecasts or model evaluations."""
import argparse
import configparser
import logging
import logging.config
import os
from argparse import Namespace
from configparser import ConfigParser
from logging import Logger
from sys import exit
from typing import Optional

from src.data.database_interaction import get_data
from src.data.process_data import sorted_with_timestamps
from src.models.statistical import cross_validate, forecast

CONFIG_PATH = 'config.toml'
LOGGER_NAME = 'main'


def main() -> None:
    """Parse arguments and run the pipeline."""
    config, args, logger = init()
    data = sorted_with_timestamps(get_data(*parse_targets(config, args)))
    match args.mode:
        case 'f':
            forecast(data, int(args.horizon), config)
        case 'cv':
            cross_validate(data, config)
        case _:
            logger.error('Unrecognized mode')
            exit(1)


def parse_targets(
    config: ConfigParser, args: Namespace
) -> tuple[Optional[list[str]], Optional[list[str]]]:
    """Parse target product and pharmacies, either from arguments or config."""
    logger = logging.getLogger(LOGGER_NAME)
    if args.product or args.pharmacy:
        pr_list = [args.product] if args.product else None
        ph_list = [args.pharmacy] if args.pharmacy else None
        return pr_list, ph_list
    pr_list = config['main']['product_ids'].split(';')
    ph_list = config['main']['pharmacy_ids'].split(';')
    if len(pr_list) != len(ph_list):
        logger.warn('Product and pharmacy id lists should be the same size')
        exit(1)
    return pr_list, ph_list


def init() -> tuple[ConfigParser, Namespace, Logger]:
    """Return a config parser, a command line argument parser and a logger."""
    parser = argparse.ArgumentParser()
    mode_help = 'action to perform: f for forecast, cv for cross-validate'
    parser.add_argument('mode', help=mode_help)
    parser.add_argument('-pr', '--product', help='product id')
    parser.add_argument('-ph', '--pharmacy', help='pharmacy id')
    parser.add_argument('-ho', '--horizon', help='forecast horizon in weeks')
    arguments = parser.parse_args()

    config = configparser.ConfigParser()
    config.read(CONFIG_PATH)

    logging.config.fileConfig(config['paths']['logging_config'])
    logger = logging.getLogger(LOGGER_NAME)

    if arguments.mode == 'f' and not arguments.horizon:
        logger.error('Forecast mode called without horizon argument')
        exit(1)

    os.environ['NIXTLA_ID_AS_COL'] = '1'
    return (config, arguments, logger)


# run with python -m src.main.main
if __name__ == '__main__':
    main()
