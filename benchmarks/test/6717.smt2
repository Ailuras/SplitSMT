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

(declare-sort var1336 0)
(declare-sort var822 0)
(declare-sort var1013 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun serviceGroup/531638023 (var1336) String)
(declare-fun var1013_isNotEmpty/-1251449450 (String) Bool)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-1166366385 (String Int) String)
(define-fun append/-1001720160 ((s String) (tail Int)) String (str.++ s (str.from_int tail)))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var1336 var1336)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const var3386 var1336) ; Statement: r1 := @this: org.apache.dubbo.rpc.support.GroupServiceKeyCache 
(assert (not (= var3386 null-var1336)))
(declare-const var3199 String) ; Statement: r3 := @parameter0: java.lang.String 
(assert (not (= var3199 null-String)))
(declare-const var3521 String) ; Statement: r4 := @parameter1: java.lang.String 
(assert (not (= var3521 null-String)))
(declare-const var384 Int) ; Statement: i0 := @parameter2: int 
(assert (not (= var384 null-Int)))
(define-const var117 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var117)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var117!1 String)
(assert (= var117!1 ""))
(define-const var3401 String (serviceGroup/531638023 var3386)) ; Statement: $r2 = r1.<org.apache.dubbo.rpc.support.GroupServiceKeyCache: java.lang.String serviceGroup> 
(define-const var2744 Bool (var1013_isNotEmpty/-1251449450 var3401)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r2) 
 ; Statement: if $z0 == 0 goto virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r3) 
(assert (= (ite var2744 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
;(assert (append/672562846 var117!1 var3199)) ; Statement: virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r3) 
(declare-const var117!2 String)
(assert (= var117!2 (str.++ var117!1 var3199)))
(define-const var2488 Bool (var1013_isNotEmpty/-1251449450 var3521)) ; Statement: $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r4) 
 ; Statement: if $z1 == 0 goto $r10 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(58) 
(assert (= (ite var2488 1 0) 0)) ; Cond: $z1 == 0 
(assert true)
(define-const var2041 String (append/-1166366385 var117!2 58)) ; Statement: $r10 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(58) 
(declare-const var117!3 String)
(assert (str.prefixof var117!2 var117!3))
(assert true)
;(assert (append/-1001720160 var2041 var384)) ; Statement: virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>(i0) 
(declare-const var2041!1 String)
(assert (str.prefixof var2041 var2041!1))
(assert true)
(define-const var2528 String (toString/-2075883882 var117!3)) ; Statement: $r11 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r11 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), serviceGroup/531638023=([org.apache.dubbo.rpc.support.GroupServiceKeyCache], java.lang.String), var1013_isNotEmpty/-1251449450=([java.lang.String], boolean), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), append/-1001720160=([java.lang.StringBuilder, int], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var1336=org.apache.dubbo.rpc.support.GroupServiceKeyCache, var3386=r1, var3199=r3, var822=null_type, var3521=r4, var384=i0, var117=$r0, var3401=$r2, var1013=org.apache.dubbo.common.utils.StringUtils, var2744=$z0, var2488=$z1, var2041=$r10, var2528=$r11}
; {org.apache.dubbo.rpc.support.GroupServiceKeyCache=var1336, r1=var3386, r3=var3199, null_type=var822, r4=var3521, i0=var384, $r0=var117, $r2=var3401, org.apache.dubbo.common.utils.StringUtils=var1013, $z0=var2744, $z1=var2488, $r10=var2041, $r11=var2528}
;seq <java.lang.StringBuilder: void <init>()>;	<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(int)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.rpc.support.GroupServiceKeyCache;	r3 := @parameter0: java.lang.String;	r4 := @parameter1: java.lang.String;	i0 := @parameter2: int;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r2 = r1.<org.apache.dubbo.rpc.support.GroupServiceKeyCache: java.lang.String serviceGroup>;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r2);	if $z0 == 0 goto virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r3);	virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r3);	$z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r4);	if $z1 == 0 goto $r10 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(58);	$r10 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(58);	virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>(i0);	$r11 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>();	return $r11
;block_num 3