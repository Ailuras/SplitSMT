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

(declare-sort var3286 0)
(declare-sort var2831 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun indexOf/-1037706067 ((s String) (c Int)) Int (str.indexof s (str.from_code c) 0))
(declare-fun lastIndexOf/-1292097097 (String Int) Int)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var2831_valueOf/-778994652 (String) var2831)
(declare-const null-String String)
(declare-const var1193 String) ; Statement: r18 := @parameter0: java.lang.String 
(assert (not (= var1193 null-String)))
(declare-const var2326 String) ; Statement: r5 := @parameter1: java.lang.String 
(assert (not (= var2326 null-String)))
(define-const var3926 String null-String) ; Statement: r19 = null 
(define-const var3802 String null-String) ; Statement: r20 = null 
(assert true)
(define-const var3360 Int (indexOf/-1037706067 var1193 47)) ; Statement: i3 = virtualinvoke r18.<java.lang.String: int indexOf(int)>(47) 
 ; Statement: if i3 <= 0 goto $i2 = virtualinvoke r18.<java.lang.String: int lastIndexOf(int)>(58) 
(assert (<= var3360 0)) ; Cond: i3 <= 0 
(assert true)
(define-const var2248 Int (lastIndexOf/-1292097097 var1193 58)) ; Statement: $i2 = virtualinvoke r18.<java.lang.String: int lastIndexOf(int)>(58) 
 ; Statement: if $i2 <= 0 goto $r0 = new java.lang.StringBuilder 
(assert (<= var2248 0)) ; Cond: $i2 <= 0 
(define-const var3692 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3692)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3692!1 String)
(assert (= var3692!1 ""))
(assert true)
(define-const var2544 String (append/672562846 var3692!1 "empty://0.0.0.0/")) ; Statement: $r1 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("empty://0.0.0.0/") 
(declare-const var3692!2 String)
(assert (= var3692!2 (str.++ var3692!1 "empty://0.0.0.0/")))
(assert true)
(define-const var327 String (append/672562846 var2544 var1193)) ; Statement: $r2 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r18) 
(declare-const var2544!1 String)
(assert (= var2544!1 (str.++ var2544 var1193)))
(assert true)
(define-const var2866 String (append/672562846 var327 "?")) ; Statement: $r3 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("?") 
(declare-const var327!1 String)
(assert (= var327!1 (str.++ var327 "?")))
(assert true)
(define-const var3228 String (append/672562846 var2866 "category")) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("category") 
(declare-const var2866!1 String)
(assert (= var2866!1 (str.++ var2866 "category")))
(assert true)
(define-const var1843 String (append/672562846 var3228 "=")) ; Statement: $r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("=") 
(declare-const var3228!1 String)
(assert (= var3228!1 (str.++ var3228 "=")))
(assert true)
(define-const var633 String (append/672562846 var1843 var2326)) ; Statement: $r10 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r5) 
(declare-const var1843!1 String)
(assert (= var1843!1 (str.++ var1843 var2326)))
 ; Statement: if r19 != null goto $r7 = new java.lang.StringBuilder 
(assert (not (not (= var3926 null-String)))) ; Negate: Cond: r19 != null  
(define-const var211 String "") ; Statement: $r21 = "" 
 ; Statement: goto [?= $r14 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r21)] 
(assert true) ; Non Conditional
(assert true)
(define-const var2001 String (append/672562846 var633 var211)) ; Statement: $r14 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r21) 
(declare-const var633!1 String)
(assert (= var633!1 (str.++ var633 var211)))
 ; Statement: if r20 != null goto $r11 = new java.lang.StringBuilder 
(assert (not (= var3802 null-String))) ; Cond: r20 != null 
(define-const var378 String String-init) ; Statement: $r11 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var378)) ; Statement: specialinvoke $r11.<java.lang.StringBuilder: void <init>()>() 
(declare-const var378!1 String)
(assert (= var378!1 ""))
(assert true)
(define-const var1714 String (append/672562846 var378!1 "&version=")) ; Statement: $r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("&version=") 
(declare-const var378!2 String)
(assert (= var378!2 (str.++ var378!1 "&version=")))
(assert true)
(define-const var1437 String (append/672562846 var1714 var3802)) ; Statement: $r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r20) 
(declare-const var1714!1 String)
(assert (= var1714!1 (str.++ var1714 var3802)))
(assert true)
(define-const var3669 String (toString/-2075883882 var1437)) ; Statement: $r22 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true) ; Non Conditional
(assert true)
(define-const var3452 String (append/672562846 var2001 var3669)) ; Statement: $r15 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r22) 
(declare-const var2001!1 String)
(assert (= var2001!1 (str.++ var2001 var3669)))
(assert true)
(define-const var1442 String (toString/-2075883882 var3452)) ; Statement: $r16 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.String toString()>() 
(define-const var3392 var2831 (var2831_valueOf/-778994652 var1442)) ; Statement: $r17 = staticinvoke <org.apache.dubbo.common.URL: org.apache.dubbo.common.URL valueOf(java.lang.String)>($r16) 
 ; Statement: return $r17 
(check-sat)
; {indexOf/-1037706067=([java.lang.String, int], int), lastIndexOf/-1292097097=([java.lang.String, int], int), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var2831_valueOf/-778994652=([java.lang.String], org.apache.dubbo.common.URL)}
; {var1193=r18, var3286=null_type, var2326=r5, var3926=r19, var3802=r20, var3360=i3, var2248=$i2, var3692=$r0, var2544=$r1, var327=$r2, var2866=$r3, var3228=$r4, var1843=$r6, var633=$r10, var211=$r21, var2001=$r14, var378=$r11, var1714=$r12, var1437=$r13, var3669=$r22, var3452=$r15, var1442=$r16, var2831=org.apache.dubbo.common.URL, var3392=$r17}
; {r18=var1193, null_type=var3286, r5=var2326, r19=var3926, r20=var3802, i3=var3360, $i2=var2248, $r0=var3692, $r1=var2544, $r2=var327, $r3=var2866, $r4=var3228, $r6=var1843, $r10=var633, $r21=var211, $r14=var2001, $r11=var378, $r12=var1714, $r13=var1437, $r22=var3669, $r15=var3452, $r16=var1442, org.apache.dubbo.common.URL=var2831, $r17=var3392}
;seq <java.lang.String: int indexOf(int)>;	<java.lang.String: int lastIndexOf(int)>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.String: int indexOf(int)>": 1,"<java.lang.String: int lastIndexOf(int)>": 1,"<java.lang.StringBuilder: void <init>()>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 10,"<java.lang.StringBuilder: java.lang.String toString()>": 2}
;stmts r18 := @parameter0: java.lang.String;	r5 := @parameter1: java.lang.String;	r19 = null;	r20 = null;	i3 = virtualinvoke r18.<java.lang.String: int indexOf(int)>(47);	if i3 <= 0 goto $i2 = virtualinvoke r18.<java.lang.String: int lastIndexOf(int)>(58);	$i2 = virtualinvoke r18.<java.lang.String: int lastIndexOf(int)>(58);	if $i2 <= 0 goto $r0 = new java.lang.StringBuilder;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r1 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("empty://0.0.0.0/");	$r2 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r18);	$r3 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("?");	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("category");	$r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("=");	$r10 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r5);	if r19 != null goto $r7 = new java.lang.StringBuilder;	$r21 = "";	goto [?= $r14 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r21)];	$r14 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r21);	if r20 != null goto $r11 = new java.lang.StringBuilder;	$r11 = new java.lang.StringBuilder;	specialinvoke $r11.<java.lang.StringBuilder: void <init>()>();	$r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("&version=");	$r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r20);	$r22 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.String toString()>();	$r15 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r22);	$r16 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.String toString()>();	$r17 = staticinvoke <org.apache.dubbo.common.URL: org.apache.dubbo.common.URL valueOf(java.lang.String)>($r16);	return $r17
;block_num 7