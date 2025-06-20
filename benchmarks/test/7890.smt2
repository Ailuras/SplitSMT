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

(declare-sort var3571 0)
(declare-sort var3395 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getSimpleName/-390194377 (ClassObject) String)
(declare-fun getLength-Arr-String-1 ((Array Int String)) Int)
(declare-fun var3395_camelToSplitName/-763255368 (String String) String)
(declare-const null-ClassObject ClassObject)
(declare-const var3571-SUFFIXES (Array Int String))
(declare-const var1570 ClassObject) ; Statement: r0 := @parameter0: java.lang.Class 
(assert (not (= var1570 null-ClassObject)))
(declare-const var346 ClassObject) ; Statement: r4 := @parameter1: java.lang.Class 
(assert (not (= var346 null-ClassObject)))
(assert true)
(define-const var2886 String (getSimpleName/-390194377 var1570)) ; Statement: r5 = virtualinvoke r0.<java.lang.Class: java.lang.String getSimpleName()>() 
(define-const var3115 (Array Int String) var3571-SUFFIXES) ; Statement: r1 = <org.apache.dubbo.config.AbstractConfig: java.lang.String[] SUFFIXES> 
(define-const var655 Int (getLength-Arr-String-1 var3115)) ; Statement: i0 = lengthof r1 
(define-const var1997 Int 0) ; Statement: i4 = 0 
(assert true) ; Non Conditional
 ; Statement: if i4 >= i0 goto $r2 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.lang.String camelToSplitName(java.lang.String,java.lang.String)>(r5, "-") 
(assert (>= var1997 var655)) ; Cond: i4 >= i0 
(define-const var34 String (var3395_camelToSplitName/-763255368 var2886 "-")) ; Statement: $r2 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.lang.String camelToSplitName(java.lang.String,java.lang.String)>(r5, "-") 
 ; Statement: return $r2 
(check-sat)
; {getSimpleName/-390194377=([java.lang.Class], java.lang.String), getLength-Arr-String-1=([java.lang.String[]], int), var3395_camelToSplitName/-763255368=([java.lang.String, java.lang.String], java.lang.String)}
; {var1570=r0, var346=r4, var2886=r5, var3571=org.apache.dubbo.config.AbstractConfig, var3115=r1, var655=i0, var1997=i4, var3395=org.apache.dubbo.common.utils.StringUtils, var34=$r2}
; {r0=var1570, r4=var346, r5=var2886, org.apache.dubbo.config.AbstractConfig=var3571, r1=var3115, i0=var655, i4=var1997, org.apache.dubbo.common.utils.StringUtils=var3395, $r2=var34}
;seq <org.apache.dubbo.common.utils.StringUtils: java.lang.String camelToSplitName(java.lang.String,java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: java.lang.String camelToSplitName(java.lang.String,java.lang.String)>": 1}
;stmts r0 := @parameter0: java.lang.Class;	r4 := @parameter1: java.lang.Class;	r5 = virtualinvoke r0.<java.lang.Class: java.lang.String getSimpleName()>();	r1 = <org.apache.dubbo.config.AbstractConfig: java.lang.String[] SUFFIXES>;	i0 = lengthof r1;	i4 = 0;	if i4 >= i0 goto $r2 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.lang.String camelToSplitName(java.lang.String,java.lang.String)>(r5, "-");	$r2 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.lang.String camelToSplitName(java.lang.String,java.lang.String)>(r5, "-");	return $r2
;block_num 3