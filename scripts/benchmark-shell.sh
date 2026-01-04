#!/usr/bin/env zsh
# Benchmark shell startup time

echo "🔍 Benchmarking shell startup time..."
echo ""

# Run 5 iterations and show results
echo "Running 5 iterations..."
for i in {1..5}; do
  printf "  Iteration $i: "
  /usr/bin/time -p zsh -i -c exit 2>&1 | grep real | awk '{print $2 "s"}'
done

echo ""
echo "📊 Single iteration with detailed breakdown:"
zsh -i -c 'time zsh -i -c exit' 2>&1 | tail -1

echo ""
echo "💡 Tips:"
echo "  • Enable profiling: uncomment 'zmodload zsh/zprof' and 'zprof' in ~/.zshrc"
echo "  • Then run: zsh -i -c 'zprof' | head -20"
echo "  • Quick test: time zsh -i -c exit"
