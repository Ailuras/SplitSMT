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

(declare-sort var2518 0)
(declare-sort var1307 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun indexOf/-1037706067 ((s String) (c Int)) Int (str.indexof s (str.from_code c) 0))
(declare-fun lastIndexOf/-1292097097 (String Int) Int)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var1307_valueOf/-778994652 (String) var1307)
(declare-const null-String String)
(declare-const var3356 String) ; Statement: r18 := @parameter0: java.lang.String 
(assert (not (= var3356 null-String)))
(declare-const var294 String) ; Statement: r5 := @parameter1: java.lang.String 
(assert (not (= var294 null-String)))
(define-const var1354 String null-String) ; Statement: r19 = null 
(define-const var2317 String null-String) ; Statement: r20 = null 
(assert true)
(define-const var3770 Int (indexOf/-1037706067 var3356 47)) ; Statement: i3 = virtualinvoke r18.<java.lang.String: int indexOf(int)>(47) 
 ; Statement: if i3 <= 0 goto $i2 = virtualinvoke r18.<java.lang.String: int lastIndexOf(int)>(58) 
(assert (<= var3770 0)) ; Cond: i3 <= 0 
(assert true)
(define-const var3527 Int (lastIndexOf/-1292097097 var3356 58)) ; Statement: $i2 = virtualinvoke r18.<java.lang.String: int lastIndexOf(int)>(58) 
 ; Statement: if $i2 <= 0 goto $r0 = new java.lang.StringBuilder 
(assert (<= var3527 0)) ; Cond: $i2 <= 0 
(define-const var1189 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1189)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1189!1 String)
(assert (= var1189!1 ""))
(assert true)
(define-const var1977 String (append/672562846 var1189!1 "empty://0.0.0.0/")) ; Statement: $r1 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("empty://0.0.0.0/") 
(declare-const var1189!2 String)
(assert (= var1189!2 (str.++ var1189!1 "empty://0.0.0.0/")))
(assert true)
(define-const var2239 String (append/672562846 var1977 var3356)) ; Statement: $r2 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r18) 
(declare-const var1977!1 String)
(assert (= var1977!1 (str.++ var1977 var3356)))
(assert true)
(define-const var2357 String (append/672562846 var2239 "?")) ; Statement: $r3 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("?") 
(declare-const var2239!1 String)
(assert (= var2239!1 (str.++ var2239 "?")))
(assert true)
(define-const var93 String (append/672562846 var2357 "category")) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("category") 
(declare-const var2357!1 String)
(assert (= var2357!1 (str.++ var2357 "category")))
(assert true)
(define-const var254 String (append/672562846 var93 "=")) ; Statement: $r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("=") 
(declare-const var93!1 String)
(assert (= var93!1 (str.++ var93 "=")))
(assert true)
(define-const var3589 String (append/672562846 var254 var294)) ; Statement: $r10 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r5) 
(declare-const var254!1 String)
(assert (= var254!1 (str.++ var254 var294)))
 ; Statement: if r19 != null goto $r7 = new java.lang.StringBuilder 
(assert (not (= var1354 null-String))) ; Cond: r19 != null 
(define-const var490 String String-init) ; Statement: $r7 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var490)) ; Statement: specialinvoke $r7.<java.lang.StringBuilder: void <init>()>() 
(declare-const var490!1 String)
(assert (= var490!1 ""))
(assert true)
(define-const var2261 String (append/672562846 var490!1 "&group=")) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("&group=") 
(declare-const var490!2 String)
(assert (= var490!2 (str.++ var490!1 "&group=")))
(assert true)
(define-const var3312 String (append/672562846 var2261 var1354)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r19) 
(declare-const var2261!1 String)
(assert (= var2261!1 (str.++ var2261 var1354)))
(assert true)
(define-const var469 String (toString/-2075883882 var3312)) ; Statement: $r21 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true) ; Non Conditional
(assert true)
(define-const var3492 String (append/672562846 var3589 var469)) ; Statement: $r14 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r21) 
(declare-const var3589!1 String)
(assert (= var3589!1 (str.++ var3589 var469)))
 ; Statement: if r20 != null goto $r11 = new java.lang.StringBuilder 
(assert (not (not (= var2317 null-String)))) ; Negate: Cond: r20 != null  
(define-const var1304 String "") ; Statement: $r22 = "" 
 ; Statement: goto [?= $r15 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r22)] 
(assert true) ; Non Conditional
(assert true)
(define-const var382 String (append/672562846 var3492 var1304)) ; Statement: $r15 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r22) 
(declare-const var3492!1 String)
(assert (= var3492!1 (str.++ var3492 var1304)))
(assert true)
(define-const var665 String (toString/-2075883882 var382)) ; Statement: $r16 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.String toString()>() 
(define-const var2258 var1307 (var1307_valueOf/-778994652 var665)) ; Statement: $r17 = staticinvoke <org.apache.dubbo.common.URL: org.apache.dubbo.common.URL valueOf(java.lang.String)>($r16) 
 ; Statement: return $r17 
(check-sat)
; {indexOf/-1037706067=([java.lang.String, int], int), lastIndexOf/-1292097097=([java.lang.String, int], int), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var1307_valueOf/-778994652=([java.lang.String], org.apache.dubbo.common.URL)}
; {var3356=r18, var2518=null_type, var294=r5, var1354=r19, var2317=r20, var3770=i3, var3527=$i2, var1189=$r0, var1977=$r1, var2239=$r2, var2357=$r3, var93=$r4, var254=$r6, var3589=$r10, var490=$r7, var2261=$r8, var3312=$r9, var469=$r21, var3492=$r14, var1304=$r22, var382=$r15, var665=$r16, var1307=org.apache.dubbo.common.URL, var2258=$r17}
; {r18=var3356, null_type=var2518, r5=var294, r19=var1354, r20=var2317, i3=var3770, $i2=var3527, $r0=var1189, $r1=var1977, $r2=var2239, $r3=var2357, $r4=var93, $r6=var254, $r10=var3589, $r7=var490, $r8=var2261, $r9=var3312, $r21=var469, $r14=var3492, $r22=var1304, $r15=var382, $r16=var665, org.apache.dubbo.common.URL=var1307, $r17=var2258}
;seq <java.lang.String: int indexOf(int)>;	<java.lang.String: int lastIndexOf(int)>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.String: int indexOf(int)>": 1,"<java.lang.String: int lastIndexOf(int)>": 1,"<java.lang.StringBuilder: void <init>()>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 10,"<java.lang.StringBuilder: java.lang.String toString()>": 2}
;stmts r18 := @parameter0: java.lang.String;	r5 := @parameter1: java.lang.String;	r19 = null;	r20 = null;	i3 = virtualinvoke r18.<java.lang.String: int indexOf(int)>(47);	if i3 <= 0 goto $i2 = virtualinvoke r18.<java.lang.String: int lastIndexOf(int)>(58);	$i2 = virtualinvoke r18.<java.lang.String: int lastIndexOf(int)>(58);	if $i2 <= 0 goto $r0 = new java.lang.StringBuilder;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r1 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("empty://0.0.0.0/");	$r2 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r18);	$r3 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("?");	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("category");	$r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("=");	$r10 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r5);	if r19 != null goto $r7 = new java.lang.StringBuilder;	$r7 = new java.lang.StringBuilder;	specialinvoke $r7.<java.lang.StringBuilder: void <init>()>();	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("&group=");	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r19);	$r21 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.String toString()>();	$r14 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r21);	if r20 != null goto $r11 = new java.lang.StringBuilder;	$r22 = "";	goto [?= $r15 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r22)];	$r15 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r22);	$r16 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.String toString()>();	$r17 = staticinvoke <org.apache.dubbo.common.URL: org.apache.dubbo.common.URL valueOf(java.lang.String)>($r16);	return $r17
;block_num 7