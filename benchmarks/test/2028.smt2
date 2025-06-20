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

(declare-sort var3826 0)
(declare-sort var2445 0)
(declare-sort var2370 0)
(declare-sort var3815 0)
(declare-sort var1664 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun parameters/-202604121 (var3826) var2370)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var2370_get/1088891777 (var2370 var3815) var3815)
(declare-fun cast-from-String-to-var3815 (String) var3815)
(declare-fun cast-from-var3815-to-String (var3815) String)
(declare-fun var1664_isEmpty/-813097145 (String) Bool)
(declare-fun getParameter/356772413 (var3826 String) String)
(declare-const null-var3826 var3826)
(declare-const null-String String)
(declare-const var2931 var3826) ; Statement: r0 := @this: org.apache.dubbo.common.Parameters 
(assert (not (= var2931 null-var3826)))
(declare-const var3427 String) ; Statement: r3 := @parameter0: java.lang.String 
(assert (not (= var3427 null-String)))
(declare-const var339 String) ; Statement: r5 := @parameter1: java.lang.String 
(assert (not (= var339 null-String)))
(define-const var601 var2370 (parameters/-202604121 var2931)) ; Statement: $r2 = r0.<org.apache.dubbo.common.Parameters: java.util.Map parameters> 
(define-const var2560 String String-init) ; Statement: $r1 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2560)) ; Statement: specialinvoke $r1.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2560!1 String)
(assert (= var2560!1 ""))
(assert true)
(define-const var3420 String (append/672562846 var2560!1 var3427)) ; Statement: $r4 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r3) 
(declare-const var2560!2 String)
(assert (= var2560!2 (str.++ var2560!1 var3427)))
(assert true)
(define-const var2905 String (append/672562846 var3420 ".")) ; Statement: $r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(".") 
(declare-const var3420!1 String)
(assert (= var3420!1 (str.++ var3420 ".")))
(assert true)
(define-const var161 String (append/672562846 var2905 var339)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r5) 
(declare-const var2905!1 String)
(assert (= var2905!1 (str.++ var2905 var339)))
(assert true)
(define-const var2897 String (toString/-2075883882 var161)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.String toString()>() 
(define-const var1203 var3815 (var2370_get/1088891777 var601 (cast-from-String-to-var3815 var2897))) ; Statement: $r9 = interfaceinvoke $r2.<java.util.Map: java.lang.Object get(java.lang.Object)>($r8) 
(define-const var3917 String (cast-from-var3815-to-String var1203)) ; Statement: r19 = (java.lang.String) $r9 
(define-const var1974 Bool (var1664_isEmpty/-813097145 var3917)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r19) 
 ; Statement: if $z0 == 0 goto $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r19) 
(assert (= (ite var1974 1 0) 0)) ; Cond: $z0 == 0 
(define-const var1908 Bool (var1664_isEmpty/-813097145 var3917)) ; Statement: $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r19) 
 ; Statement: if $z1 == 0 goto return r19 
(assert (not (= (ite var1908 1 0) 0))) ; Negate: Cond: $z1 == 0  
(assert true)
(define-const var306 String (getParameter/356772413 var2931 var339)) ; Statement: $r10 = virtualinvoke r0.<org.apache.dubbo.common.Parameters: java.lang.String getParameter(java.lang.String)>(r5) 
 ; Statement: return $r10 
(check-sat)
; {parameters/-202604121=([org.apache.dubbo.common.Parameters], java.util.Map), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var2370_get/1088891777=([java.util.Map, java.lang.Object], java.lang.Object), cast-from-String-to-var3815=([java.lang.String], java.lang.Object), cast-from-var3815-to-String=([java.lang.Object], java.lang.String), var1664_isEmpty/-813097145=([java.lang.String], boolean), getParameter/356772413=([org.apache.dubbo.common.Parameters, java.lang.String], java.lang.String)}
; {var3826=org.apache.dubbo.common.Parameters, var2931=r0, var3427=r3, var2445=null_type, var339=r5, var2370=java.util.Map, var601=$r2, var2560=$r1, var3420=$r4, var2905=$r6, var161=$r7, var2897=$r8, var3815=java.lang.Object, var1203=$r9, var3917=r19, var1664=org.apache.dubbo.common.utils.StringUtils, var1974=$z0, var1908=$z1, var306=$r10}
; {org.apache.dubbo.common.Parameters=var3826, r0=var2931, r3=var3427, null_type=var2445, r5=var339, java.util.Map=var2370, $r2=var601, $r1=var2560, $r4=var3420, $r6=var2905, $r7=var161, $r8=var2897, java.lang.Object=var3815, $r9=var1203, r19=var3917, org.apache.dubbo.common.utils.StringUtils=var1664, $z0=var1974, $z1=var1908, $r10=var306}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>;	<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>;	<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.String toString()>": 1,"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 2}
;stmts r0 := @this: org.apache.dubbo.common.Parameters;	r3 := @parameter0: java.lang.String;	r5 := @parameter1: java.lang.String;	$r2 = r0.<org.apache.dubbo.common.Parameters: java.util.Map parameters>;	$r1 = new java.lang.StringBuilder;	specialinvoke $r1.<java.lang.StringBuilder: void <init>()>();	$r4 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r3);	$r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(".");	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r5);	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.String toString()>();	$r9 = interfaceinvoke $r2.<java.util.Map: java.lang.Object get(java.lang.Object)>($r8);	r19 = (java.lang.String) $r9;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r19);	if $z0 == 0 goto $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r19);	$z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r19);	if $z1 == 0 goto return r19;	$r10 = virtualinvoke r0.<org.apache.dubbo.common.Parameters: java.lang.String getParameter(java.lang.String)>(r5);	return $r10
;block_num 3