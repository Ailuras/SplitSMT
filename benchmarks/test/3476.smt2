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

(declare-sort var1357 0)
(declare-sort var3988 0)
(declare-sort var3477 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3988_getKeyIndex/82410026 (Bool String) Int)
(declare-fun var3477-init () var3477)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/875830710 (var3477 String) void)
(declare-const null-String String)
(declare-const var1384 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var1384 null-String)))
(declare-const var3273 String) ; Statement: r3 := @parameter1: java.lang.String 
(assert (not (= var3273 null-String)))
(define-const var1401 Int (var3988_getKeyIndex/82410026 (ite (= 1 1) true false) var1384)) ; Statement: i0 = staticinvoke <org.apache.dubbo.common.url.component.param.DynamicParamTable: int getKeyIndex(boolean,java.lang.String)>(1, r0) 
 ; Statement: if i0 >= 0 goto $r1 = <org.apache.dubbo.common.url.component.param.DynamicParamTable: org.apache.dubbo.common.url.component.param.ParamValue[] VALUES> 
(assert (not (>= var1401 0))) ; Negate: Cond: i0 >= 0  
(define-const var2018 var3477 var3477-init) ; Statement: $r4 = new java.lang.IllegalArgumentException 
(define-const var1213 String String-init) ; Statement: $r5 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1213)) ; Statement: specialinvoke $r5.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1213!1 String)
(assert (= var1213!1 ""))
(assert true)
(define-const var40 String (append/672562846 var1213!1 "Cannot found key in url param:")) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Cannot found key in url param:") 
(declare-const var1213!2 String)
(assert (= var1213!2 (str.++ var1213!1 "Cannot found key in url param:")))
(assert true)
(define-const var3139 String (append/672562846 var40 var1384)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r0) 
(declare-const var40!1 String)
(assert (= var40!1 (str.++ var40 var1384)))
(assert true)
(define-const var410 String (toString/-2075883882 var3139)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/875830710 var2018 var410)) ; Statement: specialinvoke $r4.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>($r8) 

(declare-const var2018!1 var3477)
(declare-const var410!1 String)
 ; Statement: throw $r4 
(check-sat)
; {var3988_getKeyIndex/82410026=([boolean, java.lang.String], int), var3477-init=([], java.lang.IllegalArgumentException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/875830710=([java.lang.IllegalArgumentException, java.lang.String], void)}
; {var1384=r0, var1357=null_type, var3273=r3, var3988=org.apache.dubbo.common.url.component.param.DynamicParamTable, var1401=i0, var3477=java.lang.IllegalArgumentException, var2018=$r4, var1213=$r5, var40=$r6, var3139=$r7, var410=$r8}
; {r0=var1384, null_type=var1357, r3=var3273, org.apache.dubbo.common.url.component.param.DynamicParamTable=var3988, i0=var1401, java.lang.IllegalArgumentException=var3477, $r4=var2018, $r5=var1213, $r6=var40, $r7=var3139, $r8=var410}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @parameter0: java.lang.String;	r3 := @parameter1: java.lang.String;	i0 = staticinvoke <org.apache.dubbo.common.url.component.param.DynamicParamTable: int getKeyIndex(boolean,java.lang.String)>(1, r0);	if i0 >= 0 goto $r1 = <org.apache.dubbo.common.url.component.param.DynamicParamTable: org.apache.dubbo.common.url.component.param.ParamValue[] VALUES>;	$r4 = new java.lang.IllegalArgumentException;	$r5 = new java.lang.StringBuilder;	specialinvoke $r5.<java.lang.StringBuilder: void <init>()>();	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Cannot found key in url param:");	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r0);	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r4.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>($r8);	throw $r4
;block_num 2