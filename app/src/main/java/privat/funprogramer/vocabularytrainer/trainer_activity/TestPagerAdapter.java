package privat.funprogramer.vocabularytrainer.trainer_activity;

import privat.funprogramer.vocabularytrainer.Callback;

public interface TestPagerAdapter {

    int getItemCount();

    void registerOnNumberOfPagesChanged(Callback callback);

    int getNumberOfVisiblePages();

    void setNumberOfVisiblePages(int numberOfVisiblePages);

}
