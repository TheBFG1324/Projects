class Solution:
    def findMedianSortedArray(self, l1, l2):
        n = len(l1)
        m = len(l2)
        l1_index = 0
        l2_index = 0
        sorted_array = []
        key=True
        while key:
            if l1_index==n:
                for num in l2[l2_index::]:
                    sorted_array.append(num)
                    key=False
            elif l2_index==m:
                for num in l1[l1_index::]:
                    sorted_array.append(num)
                    key=False

            elif l1[l1_index] < l2[l2_index]:
                sorted_array.append(l1[l1_index])
                l1_index += 1
            else:
                sorted_array.append(l2[l2_index])
                l2_index += 1
        total_length=len(sorted_array)
        if total_length%2!=0:
            index=total_length//2+ total_length%2
            return sorted_array[index-1]
        else:
            return float(sorted_array[total_length//2]+sorted_array[total_length//2-1])/2

        


x = Solution()
l1 = [1, 3, 5, 6,7, 11]
l2 = [2,2,3,4, 6, 8]
print(x.findMedianSortedArray(l1, l2))
