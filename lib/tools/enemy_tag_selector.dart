String enemyTagSelector(String tag) {
  switch (tag) {
    case 'animated':
      return '요괴';
    case 'drone':
      return '드론';
    case 'infection':
      return '감염생물';
    case 'machine':
      return '기계';
    case 'mutant':
      return '숙주';
    case 'originiumartscraft':
      return '아츠 피조물';
    case 'seamonster':
      return '바다 괴물';
    case 'sarkaz':
      return '살카즈';
  }
  return tag;
}
