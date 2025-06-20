(set-option :produce-unsat-cores true) ; enable generation of unsat cores
(set-option :produce-models true) ; enable model generation
(set-logic ALL)

; 统一获取长度的函数
(define-fun get_split_length ((x String) (d String) (limit Int)) Int
  (ite
    (> limit 0)
    (ite (< (str.num_splits x d) limit)
         (str.num_splits x d)
         limit)
    (str.num_splits x d)
  )
)

; 统一获取元素的函数
(define-fun get_split_element ((x String) (d String) (limit Int) (i Int)) String
  (ite
    (and (> limit 0)
         (= i (- limit 1))
         (>= (str.num_splits x d) limit))
    (str.split_rest x d (- limit 1))
    (str.split_at x d i)
  )
)

(declare-sort var2055 0)
(declare-sort var1384 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun indexOf/-1037706067 ((s String) (c Int)) Int (str.indexof s (str.from_code c) 0))
(declare-fun lastIndexOf/-1292097097 (String Int) Int)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var1384_valueOf/-778994652 (String) var1384)
(declare-const null-String String)
(declare-const var2922 String) ; Statement: r18 := @parameter0: java.lang.String 
(assert (not (= var2922 null-String)))
(declare-const var3737 String) ; Statement: r5 := @parameter1: java.lang.String 
(assert (not (= var3737 null-String)))
(define-const var2231 String null-String) ; Statement: r19 = null 
(define-const var975 String null-String) ; Statement: r20 = null 
(assert true)
(define-const var2204 Int (indexOf/-1037706067 var2922 47)) ; Statement: i3 = virtualinvoke r18.<java.lang.String: int indexOf(int)>(47) 
 ; Statement: if i3 <= 0 goto $i2 = virtualinvoke r18.<java.lang.String: int lastIndexOf(int)>(58) 
(assert (<= var2204 0)) ; Cond: i3 <= 0 
(assert true)
(define-const var2173 Int (lastIndexOf/-1292097097 var2922 58)) ; Statement: $i2 = virtualinvoke r18.<java.lang.String: int lastIndexOf(int)>(58) 
 ; Statement: if $i2 <= 0 goto $r0 = new java.lang.StringBuilder 
(assert (<= var2173 0)) ; Cond: $i2 <= 0 
(define-const var1734 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1734)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1734!1 String)
(assert (= var1734!1 ""))
(assert true)
(define-const var21 String (append/672562846 var1734!1 "empty://0.0.0.0/")) ; Statement: $r1 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("empty://0.0.0.0/") 
(declare-const var1734!2 String)
(assert (= var1734!2 (str.++ var1734!1 "empty://0.0.0.0/")))
(assert true)
(define-const var2074 String (append/672562846 var21 var2922)) ; Statement: $r2 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r18) 
(declare-const var21!1 String)
(assert (= var21!1 (str.++ var21 var2922)))
(assert true)
(define-const var800 String (append/672562846 var2074 "?")) ; Statement: $r3 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("?") 
(declare-const var2074!1 String)
(assert (= var2074!1 (str.++ var2074 "?")))
(assert true)
(define-const var3377 String (append/672562846 var800 "category")) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("category") 
(declare-const var800!1 String)
(assert (= var800!1 (str.++ var800 "category")))
(assert true)
(define-const var3751 String (append/672562846 var3377 "=")) ; Statement: $r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("=") 
(declare-const var3377!1 String)
(assert (= var3377!1 (str.++ var3377 "=")))
(assert true)
(define-const var1349 String (append/672562846 var3751 var3737)) ; Statement: $r10 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r5) 
(declare-const var3751!1 String)
(assert (= var3751!1 (str.++ var3751 var3737)))
 ; Statement: if r19 != null goto $r7 = new java.lang.StringBuilder 
(assert (not (not (= var2231 null-String)))) ; Negate: Cond: r19 != null  
(define-const var654 String "") ; Statement: $r21 = "" 
 ; Statement: goto [?= $r14 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r21)] 
(assert true) ; Non Conditional
(assert true)
(define-const var299 String (append/672562846 var1349 var654)) ; Statement: $r14 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r21) 
(declare-const var1349!1 String)
(assert (= var1349!1 (str.++ var1349 var654)))
 ; Statement: if r20 != null goto $r11 = new java.lang.StringBuilder 
(assert (not (not (= var975 null-String)))) ; Negate: Cond: r20 != null  
(define-const var45 String "") ; Statement: $r22 = "" 
 ; Statement: goto [?= $r15 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r22)] 
(assert true) ; Non Conditional
(assert true)
(define-const var2805 String (append/672562846 var299 var45)) ; Statement: $r15 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r22) 
(declare-const var299!1 String)
(assert (= var299!1 (str.++ var299 var45)))
(assert true)
(define-const var2582 String (toString/-2075883882 var2805)) ; Statement: $r16 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.String toString()>() 
(define-const var2143 var1384 (var1384_valueOf/-778994652 var2582)) ; Statement: $r17 = staticinvoke <org.apache.dubbo.common.URL: org.apache.dubbo.common.URL valueOf(java.lang.String)>($r16) 
 ; Statement: return $r17 
(check-sat)
; {indexOf/-1037706067=([java.lang.String, int], int), lastIndexOf/-1292097097=([java.lang.String, int], int), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var1384_valueOf/-778994652=([java.lang.String], org.apache.dubbo.common.URL)}
; {var2922=r18, var2055=null_type, var3737=r5, var2231=r19, var975=r20, var2204=i3, var2173=$i2, var1734=$r0, var21=$r1, var2074=$r2, var800=$r3, var3377=$r4, var3751=$r6, var1349=$r10, var654=$r21, var299=$r14, var45=$r22, var2805=$r15, var2582=$r16, var1384=org.apache.dubbo.common.URL, var2143=$r17}
; {r18=var2922, null_type=var2055, r5=var3737, r19=var2231, r20=var975, i3=var2204, $i2=var2173, $r0=var1734, $r1=var21, $r2=var2074, $r3=var800, $r4=var3377, $r6=var3751, $r10=var1349, $r21=var654, $r14=var299, $r22=var45, $r15=var2805, $r16=var2582, org.apache.dubbo.common.URL=var1384, $r17=var2143}
;seq <java.lang.String: int indexOf(int)>;	<java.lang.String: int lastIndexOf(int)>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.String: int indexOf(int)>": 1,"<java.lang.String: int lastIndexOf(int)>": 1,"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 8,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r18 := @parameter0: java.lang.String;	r5 := @parameter1: java.lang.String;	r19 = null;	r20 = null;	i3 = virtualinvoke r18.<java.lang.String: int indexOf(int)>(47);	if i3 <= 0 goto $i2 = virtualinvoke r18.<java.lang.String: int lastIndexOf(int)>(58);	$i2 = virtualinvoke r18.<java.lang.String: int lastIndexOf(int)>(58);	if $i2 <= 0 goto $r0 = new java.lang.StringBuilder;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r1 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("empty://0.0.0.0/");	$r2 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r18);	$r3 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("?");	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("category");	$r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("=");	$r10 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r5);	if r19 != null goto $r7 = new java.lang.StringBuilder;	$r21 = "";	goto [?= $r14 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r21)];	$r14 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r21);	if r20 != null goto $r11 = new java.lang.StringBuilder;	$r22 = "";	goto [?= $r15 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r22)];	$r15 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r22);	$r16 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.String toString()>();	$r17 = staticinvoke <org.apache.dubbo.common.URL: org.apache.dubbo.common.URL valueOf(java.lang.String)>($r16);	return $r17
;block_num 7