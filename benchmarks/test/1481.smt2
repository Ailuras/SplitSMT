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

(declare-sort var1318 0)
(declare-sort var1939 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun isPrimitive/-473230874 (ClassObject) Bool)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun var1939_getName/715767591 (ClassObject) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-ClassObject ClassObject)
(declare-const null-String String)
(declare-const var3528 ClassObject) ; Statement: r0 := @parameter0: java.lang.Class 
(assert (not (= var3528 null-ClassObject)))
(declare-const var1058 String) ; Statement: r5 := @parameter1: java.lang.String 
(assert (not (= var1058 null-String)))
(assert true)
(define-const var503 Bool (isPrimitive/-473230874 var3528)) ; Statement: $z0 = virtualinvoke r0.<java.lang.Class: boolean isPrimitive()>() 
 ; Statement: if $z0 == 0 goto $r1 = new java.lang.StringBuilder 
(assert (= (ite var503 1 0) 0)) ; Cond: $z0 == 0 
(define-const var3911 String String-init) ; Statement: $r1 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3911)) ; Statement: specialinvoke $r1.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3911!1 String)
(assert (= var3911!1 ""))
(assert true)
(define-const var1308 String (append/672562846 var3911!1 "(")) ; Statement: $r3 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("(") 
(declare-const var3911!2 String)
(assert (= var3911!2 (str.++ var3911!1 "(")))
(define-const var2989 String (var1939_getName/715767591 var3528)) ; Statement: $r2 = staticinvoke <org.apache.dubbo.common.utils.ReflectUtils: java.lang.String getName(java.lang.Class)>(r0) 
(assert true)
(define-const var1340 String (append/672562846 var1308 var2989)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2) 
(declare-const var1308!1 String)
(assert (= var1308!1 (str.++ var1308 var2989)))
(assert true)
(define-const var1791 String (append/672562846 var1340 ")")) ; Statement: $r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(")") 
(declare-const var1340!1 String)
(assert (= var1340!1 (str.++ var1340 ")")))
(assert true)
(define-const var1100 String (append/672562846 var1791 var1058)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r5) 
(declare-const var1791!1 String)
(assert (= var1791!1 (str.++ var1791 var1058)))
(assert true)
(define-const var1114 String (toString/-2075883882 var1100)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r8 
(check-sat)
; {isPrimitive/-473230874=([java.lang.Class], boolean), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), var1939_getName/715767591=([java.lang.Class], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var3528=r0, var1058=r5, var1318=null_type, var503=$z0, var3911=$r1, var1308=$r3, var1939=org.apache.dubbo.common.utils.ReflectUtils, var2989=$r2, var1340=$r4, var1791=$r6, var1100=$r7, var1114=$r8}
; {r0=var3528, r5=var1058, null_type=var1318, $z0=var503, $r1=var3911, $r3=var1308, org.apache.dubbo.common.utils.ReflectUtils=var1939, $r2=var2989, $r4=var1340, $r6=var1791, $r7=var1100, $r8=var1114}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 4,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @parameter0: java.lang.Class;	r5 := @parameter1: java.lang.String;	$z0 = virtualinvoke r0.<java.lang.Class: boolean isPrimitive()>();	if $z0 == 0 goto $r1 = new java.lang.StringBuilder;	$r1 = new java.lang.StringBuilder;	specialinvoke $r1.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("(");	$r2 = staticinvoke <org.apache.dubbo.common.utils.ReflectUtils: java.lang.String getName(java.lang.Class)>(r0);	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2);	$r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(")");	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r5);	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.String toString()>();	return $r8
;block_num 2