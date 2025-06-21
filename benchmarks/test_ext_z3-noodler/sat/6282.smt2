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

(declare-sort var3619 0)
(declare-sort var2393 0)
(declare-sort var1097 0)
(declare-sort var1360 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun chars/1569100760 (String) var2393)
(declare-fun var1360_bootstrap$/-977945743 () var1097)
(declare-fun var2393_allMatch/-538505270 (var2393 var1097) Bool)
(declare-const null-String String)
(declare-const var1337 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var1337 null-String)))
 ; Statement: if r0 != null goto $r2 = virtualinvoke r0.<java.lang.String: java.util.stream.IntStream chars()>() 
(assert (not (= var1337 null-String))) ; Cond: r0 != null 
(assert true)
(define-const var879 var2393 (chars/1569100760 var1337)) ; Statement: $r2 = virtualinvoke r0.<java.lang.String: java.util.stream.IntStream chars()>() 
(define-const var2842 var1097 var1360_bootstrap$/-977945743) ; Statement: $r1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils$lambda_isWord_1__299: java.util.function.IntPredicate bootstrap$()>() 
(define-const var575 Bool (var2393_allMatch/-538505270 var879 var2842)) ; Statement: $z0 = interfaceinvoke $r2.<java.util.stream.IntStream: boolean allMatch(java.util.function.IntPredicate)>($r1) 
 ; Statement: return $z0 
(check-sat)
; {chars/1569100760=([java.lang.String], java.util.stream.IntStream), var1360_bootstrap$/-977945743=([], java.util.function.IntPredicate), var2393_allMatch/-538505270=([java.util.stream.IntStream, java.util.function.IntPredicate], boolean)}
; {var1337=r0, var3619=null_type, var2393=java.util.stream.IntStream, var879=$r2, var1097=java.util.function.IntPredicate, var1360=org.apache.dubbo.common.utils.StringUtils$lambda_isWord_1__299, var2842=$r1, var575=$z0}
; {r0=var1337, null_type=var3619, java.util.stream.IntStream=var2393, $r2=var879, java.util.function.IntPredicate=var1097, org.apache.dubbo.common.utils.StringUtils$lambda_isWord_1__299=var1360, $r1=var2842, $z0=var575}
;seq <java.lang.String: java.util.stream.IntStream chars()>;	<org.apache.dubbo.common.utils.StringUtils$lambda_isWord_1__299: java.util.function.IntPredicate bootstrap$()>
;cnt {"<java.lang.String: java.util.stream.IntStream chars()>": 1,"<org.apache.dubbo.common.utils.StringUtils$lambda_isWord_1__299: java.util.function.IntPredicate bootstrap$()>": 1}
;stmts r0 := @parameter0: java.lang.String;	if r0 != null goto $r2 = virtualinvoke r0.<java.lang.String: java.util.stream.IntStream chars()>();	$r2 = virtualinvoke r0.<java.lang.String: java.util.stream.IntStream chars()>();	$r1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils$lambda_isWord_1__299: java.util.function.IntPredicate bootstrap$()>();	$z0 = interfaceinvoke $r2.<java.util.stream.IntStream: boolean allMatch(java.util.function.IntPredicate)>($r1);	return $z0
;block_num 2