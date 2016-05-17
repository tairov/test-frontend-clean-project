'use strict';

const path = require('path');
const webpack = require('webpack');
const autoprefixer = require('autoprefixer');
const ExtractTextPlugin = require('extract-text-webpack-plugin');

const NODE_ENV = process.env.SYMFONY_ENV || process.env.NODE_ENV || 'dev';
const FRONTEND_APP_DIR = path.join(__dirname, 'app/Resources/frontend');

const sassLoaders = [
    'css-loader',
    'postcss-loader',
    'sass-loader'
];

const extractCSS = new ExtractTextPlugin('styles.css', {
    allChunks: true
});

module.exports = {
    context: FRONTEND_APP_DIR,
    entry: [
        './js/app',
        './styles/styles'
        //,
        //'bootstrap-loader/extractStyles'
    ],

    output: {
        path: path.join(__dirname, 'web/public'),
        filename: 'built.js',
        publicPath: ''
    },

    module: {
        loaders: [
            { test: require.resolve("jquery"), loader: "expose?$!expose?jQuery" },
            { test: require.resolve("lodash"), loader: "expose?_" },
            { test: /\.coffee$/, loader: 'coffee' },
            {
                test: /\.css$|\.scss$|\.sass$/,
                loader: extractCSS.extract('style-loader', sassLoaders.join('!'))
            },
            {
                test: /\.woff(2)?(\?v=[0-9]\.[0-9]\.[0-9])?$/,
                loader: "url-loader?limit=10000&mimetype=application/font-woff"
            },
            { test: /\.jpe?g$|\.gif$|\.png$|\.ttf|\.eot(\?v=\d+\.\d+\.\d+)?$/, loader: 'file' },
            {
                test: /\.svg(\?v=\d+\.\d+\.\d+)?$/,
                loader: "url?limit=10000&mimetype=image/svg+xml"
            }
        ]
    },

    watch: NODE_ENV == 'dev',
    watchOptions: {
        aggregateTimeout: 100
    },
    
    //devtool: NODE_ENV == 'dev' ? 'source-map' : null,
    
    resolve: {
        modulesDirectories: [FRONTEND_APP_DIR, 'node_modules'],
        extensions: ['', '.js', '.coffee', '.scss', '.sass', '.css']
    },

    resolveLoader: {
        modulesDirectories: ['node_modules'],
        moduleTemplates: ['*-loader', '*'],
        extension: ['', '.js', '.coffee', '.scss', '.sass', '.css']
    },
    postcss: [
        autoprefixer({
            browsers: ['last 2 versions']
        })
    ],
    plugins: [
        new webpack.NoErrorsPlugin(),
        extractCSS
    ]
};

if (NODE_ENV == 'prod') {
    module.exports.plugins.push(
        new webpack.optimize.UglifyJsPlugin({
            compress: {
                warnings: false,
                drop_console: true,
                unsafe: true
            }
        })
    );
}
