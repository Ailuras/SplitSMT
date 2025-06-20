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

(declare-sort var385 0)
(declare-sort var3742 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun isPrimitive/-473230874 (ClassObject) Bool)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun var3742_getName/715767591 (ClassObject) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-ClassObject ClassObject)
(declare-const null-String String)
(declare-const var525 ClassObject) ; Statement: r0 := @parameter0: java.lang.Class 
(assert (not (= var525 null-ClassObject)))
(declare-const var675 String) ; Statement: r5 := @parameter1: java.lang.String 
(assert (not (= var675 null-String)))
(assert true)
(define-const var2778 Bool (isPrimitive/-473230874 var525)) ; Statement: $z0 = virtualinvoke r0.<java.lang.Class: boolean isPrimitive()>() 
 ; Statement: if $z0 == 0 goto $r1 = new java.lang.StringBuilder 
(assert (= (ite var2778 1 0) 0)) ; Cond: $z0 == 0 
(define-const var805 String String-init) ; Statement: $r1 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var805)) ; Statement: specialinvoke $r1.<java.lang.StringBuilder: void <init>()>() 
(declare-const var805!1 String)
(assert (= var805!1 ""))
(assert true)
(define-const var276 String (append/672562846 var805!1 "(")) ; Statement: $r3 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("(") 
(declare-const var805!2 String)
(assert (= var805!2 (str.++ var805!1 "(")))
(define-const var1418 String (var3742_getName/715767591 var525)) ; Statement: $r2 = staticinvoke <org.apache.dubbo.common.utils.ReflectUtils: java.lang.String getName(java.lang.Class)>(r0) 
(assert true)
(define-const var1504 String (append/672562846 var276 var1418)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2) 
(declare-const var276!1 String)
(assert (= var276!1 (str.++ var276 var1418)))
(assert true)
(define-const var1917 String (append/672562846 var1504 ")")) ; Statement: $r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(")") 
(declare-const var1504!1 String)
(assert (= var1504!1 (str.++ var1504 ")")))
(assert true)
(define-const var516 String (append/672562846 var1917 var675)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r5) 
(declare-const var1917!1 String)
(assert (= var1917!1 (str.++ var1917 var675)))
(assert true)
(define-const var254 String (toString/-2075883882 var516)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r8 
(check-sat)
; {isPrimitive/-473230874=([java.lang.Class], boolean), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), var3742_getName/715767591=([java.lang.Class], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var525=r0, var675=r5, var385=null_type, var2778=$z0, var805=$r1, var276=$r3, var3742=org.apache.dubbo.common.utils.ReflectUtils, var1418=$r2, var1504=$r4, var1917=$r6, var516=$r7, var254=$r8}
; {r0=var525, r5=var675, null_type=var385, $z0=var2778, $r1=var805, $r3=var276, org.apache.dubbo.common.utils.ReflectUtils=var3742, $r2=var1418, $r4=var1504, $r6=var1917, $r7=var516, $r8=var254}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 4,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @parameter0: java.lang.Class;	r5 := @parameter1: java.lang.String;	$z0 = virtualinvoke r0.<java.lang.Class: boolean isPrimitive()>();	if $z0 == 0 goto $r1 = new java.lang.StringBuilder;	$r1 = new java.lang.StringBuilder;	specialinvoke $r1.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("(");	$r2 = staticinvoke <org.apache.dubbo.common.utils.ReflectUtils: java.lang.String getName(java.lang.Class)>(r0);	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2);	$r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(")");	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r5);	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.String toString()>();	return $r8
;block_num 2