//
//  HomeCategoryData.swift
//  BunJang
//
//  Created by 최지철 on 2023/03/05.
//

import Foundation

struct Category {
    var imgName: String
    var Name: String
}

class homeCategorydata {
    var homeCategory = [  //14개
        Category(imgName: "번개케어", Name: "번개케어"),
        Category(imgName: "뉴발란스", Name: "뉴발란스"),
        Category(imgName: "찜", Name: "찜"),
        Category(imgName: "남성패딩점퍼", Name: "남성패딩점퍼"),
        Category(imgName: "최근본상품", Name: "최근본상품"),
        Category(imgName: "팔로잉브랜드", Name: "팔로잉브랜드"),
        Category(imgName: "내피드", Name: "내피드"),
        Category(imgName: "아더에러", Name: "아더에러"),
        Category(imgName: "내폰시세", Name: "내폰시세"),
        Category(imgName: "폴리테루", Name: "폴리테루"),
        Category(imgName: "우리동네", Name: "우리동네"),
        Category(imgName: "블라인드파일즈", Name: "블라인드파일즈"),
        Category(imgName: "전체메뉴", Name: "전체메뉴"),
        Category(imgName: "포인트모으기", Name: "포인트모으기"),


    ]
}
class habbitCategorydata {
    var habbitCategory = [  //12개
        Category(imgName: "신발", Name: "스니커즈"),
        Category(imgName: "오토바이스쿠터", Name: "오토바이/스쿠터"),
        Category(imgName: "축구", Name: "축구"),
        Category(imgName: "시계", Name: "시계"),
        Category(imgName: "인형피규어", Name: "피규어/인형"),
        Category(imgName: "전독킥보드", Name: "전동킥보드"),
        Category(imgName: "스타굿즈", Name: "스타굿즈"),
        Category(imgName: "닌텐도", Name: "닌텐도/NDS/Wil"),
        Category(imgName: "캠핑", Name: "캠핑"),
        Category(imgName: "자전거", Name: "자전거"),
        Category(imgName: "헬스", Name: "헬스/요가"),
        Category(imgName: "카메라", Name: "카메라/DSLR")
    ]
    var tradeCategory = [  //24개
        Category(imgName: "여성의류", Name: "여성의류"),
        Category(imgName: "시계주얼리", Name: "시계/쥬얼리"),
        Category(imgName: "차량오토바이", Name: "차량/오토바이"),
        Category(imgName: "음반악기", Name: "음반/악기"),
        Category(imgName: "생활주방용품", Name: "생활/주방용품"),
        Category(imgName: "반려동물용품", Name: "반려동물용품"),
        Category(imgName: "남성의류", Name: "남성의류"),
        Category(imgName: "패션액세서리", Name: "패션 액세서리"),
        Category(imgName: "스타굿즈", Name: "스타굿즈"),
        Category(imgName: "도서티켓문구", Name: "도서/티켓/문구"),
        Category(imgName: "공구산업용품", Name: "공구/산업용품"),
        Category(imgName: "기타", Name: "기타"),
        Category(imgName: "신발", Name: "신발"),
        Category(imgName: "디지털가전", Name: "디지털/가전"),
        Category(imgName: "키덜트", Name: "키덜트"),
        Category(imgName: "뷰티미용", Name: "뷰티/미용"),
        Category(imgName: "식품", Name: "식품"),
        Category(imgName: "번개나눔", Name: "번개나눔"),
        Category(imgName: "가방", Name: "가방"),
        Category(imgName: "스포츠레저", Name: "스포츠/레저"),
        Category(imgName: "예술희귀수집품", Name: "예술/희귀/수집품"),
        Category(imgName: "가구인테리어", Name: "가구/인테리어"),
        Category(imgName: "유아동출산", Name: "유아동/출산"),
        Category(imgName: "커뮤니티", Name: "커뮤니티"),
    ]
    var lifeCategory = [  //12개
        Category(imgName: "지역서비스", Name: "지역서비스"),
        Category(imgName: "원룸함께살아요", Name: "원룸/함께살아요"),
        Category(imgName: "구인구직", Name: "구인구직"),
        Category(imgName: "재능", Name: "재능"),
    ]
}

