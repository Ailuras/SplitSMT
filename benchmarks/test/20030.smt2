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

(declare-sort var381 0)
(declare-sort var2367 0)
(declare-sort var2095 0)
(declare-sort var640 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun var2095_identityHashCode/1096208673 (var640) Int)
(declare-fun cast-from-var381-to-var640 (var381) var640)
(define-fun append/-1001720160 ((s String) (tail Int)) String (str.++ s (str.from_int tail)))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var381 var381)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const var943 var381) ; Statement: r1 := @parameter0: org.apache.dubbo.remoting.Channel 
(assert (not (= var943 null-var381)))
(declare-const var3685 String) ; Statement: r4 := @parameter1: java.lang.String 
(assert (not (= var3685 null-String)))
(declare-const var2315 Int) ; Statement: i1 := @parameter2: int 
(assert (not (= var2315 null-Int)))
(define-const var1822 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1822)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1822!1 String)
(assert (= var1822!1 ""))
(assert true)
(define-const var934 String (append/672562846 var1822!1 "callback.service.proxy.")) ; Statement: $r2 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("callback.service.proxy.") 
(declare-const var1822!2 String)
(assert (= var1822!2 (str.++ var1822!1 "callback.service.proxy.")))
(define-const var1140 Int (var2095_identityHashCode/1096208673 (cast-from-var381-to-var640 var943))) ; Statement: $i0 = staticinvoke <java.lang.System: int identityHashCode(java.lang.Object)>(r1) 
(assert true)
(define-const var3677 String (append/-1001720160 var934 var1140)) ; Statement: $r3 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i0) 
(declare-const var934!1 String)
(assert (str.prefixof var934 var934!1))
(assert true)
(define-const var2532 String (append/672562846 var3677 ".")) ; Statement: $r5 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(".") 
(declare-const var3677!1 String)
(assert (= var3677!1 (str.++ var3677 ".")))
(assert true)
(define-const var3812 String (append/672562846 var2532 var3685)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r4) 
(declare-const var2532!1 String)
(assert (= var2532!1 (str.++ var2532 var3685)))
(assert true)
(define-const var1149 String (append/672562846 var3812 ".")) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(".") 
(declare-const var3812!1 String)
(assert (= var3812!1 (str.++ var3812 ".")))
(assert true)
(define-const var1494 String (append/-1001720160 var1149 var2315)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>(i1) 
(declare-const var1149!1 String)
(assert (str.prefixof var1149 var1149!1))
(assert true)
(define-const var3154 String (toString/-2075883882 var1494)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r9 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), var2095_identityHashCode/1096208673=([java.lang.Object], int), cast-from-var381-to-var640=([org.apache.dubbo.remoting.Channel], java.lang.Object), append/-1001720160=([java.lang.StringBuilder, int], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var381=org.apache.dubbo.remoting.Channel, var943=r1, var3685=r4, var2367=null_type, var2315=i1, var1822=$r0, var934=$r2, var2095=java.lang.System, var640=java.lang.Object, var1140=$i0, var3677=$r3, var2532=$r5, var3812=$r6, var1149=$r7, var1494=$r8, var3154=$r9}
; {org.apache.dubbo.remoting.Channel=var381, r1=var943, r4=var3685, null_type=var2367, i1=var2315, $r0=var1822, $r2=var934, java.lang.System=var2095, java.lang.Object=var640, $i0=var1140, $r3=var3677, $r5=var2532, $r6=var3812, $r7=var1149, $r8=var1494, $r9=var3154}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 4,"<java.lang.StringBuilder: java.lang.StringBuilder append(int)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @parameter0: org.apache.dubbo.remoting.Channel;	r4 := @parameter1: java.lang.String;	i1 := @parameter2: int;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r2 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("callback.service.proxy.");	$i0 = staticinvoke <java.lang.System: int identityHashCode(java.lang.Object)>(r1);	$r3 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i0);	$r5 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(".");	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r4);	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(".");	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>(i1);	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.String toString()>();	return $r9
;block_num 1