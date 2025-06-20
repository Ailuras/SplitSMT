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

(declare-sort var465 0)
(declare-sort var873 0)
(declare-sort var609 0)
(declare-sort var2551 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun chars/1569100760 (String) var873)
(declare-fun var2551_bootstrap$/1993676151 (Int) var609)
(declare-fun var873_allMatch/-538505270 (var873 var609) Bool)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const var133 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var133 null-String)))
(declare-const var1052 Int) ; Statement: c0 := @parameter1: char 
(assert (not (= var1052 null-Int)))
 ; Statement: if r0 != null goto $r2 = virtualinvoke r0.<java.lang.String: java.util.stream.IntStream chars()>() 
(assert (not (= var133 null-String))) ; Cond: r0 != null 
(assert true)
(define-const var3698 var873 (chars/1569100760 var133)) ; Statement: $r2 = virtualinvoke r0.<java.lang.String: java.util.stream.IntStream chars()>() 
(define-const var3886 var609 (var2551_bootstrap$/1993676151 var1052)) ; Statement: $r1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils$lambda_isSplitCase_0__298: java.util.function.IntPredicate bootstrap$(char)>(c0) 
(define-const var2540 Bool (var873_allMatch/-538505270 var3698 var3886)) ; Statement: $z0 = interfaceinvoke $r2.<java.util.stream.IntStream: boolean allMatch(java.util.function.IntPredicate)>($r1) 
 ; Statement: return $z0 
(check-sat)
; {chars/1569100760=([java.lang.String], java.util.stream.IntStream), var2551_bootstrap$/1993676151=([char], java.util.function.IntPredicate), var873_allMatch/-538505270=([java.util.stream.IntStream, java.util.function.IntPredicate], boolean)}
; {var133=r0, var465=null_type, var1052=c0, var873=java.util.stream.IntStream, var3698=$r2, var609=java.util.function.IntPredicate, var2551=org.apache.dubbo.common.utils.StringUtils$lambda_isSplitCase_0__298, var3886=$r1, var2540=$z0}
; {r0=var133, null_type=var465, c0=var1052, java.util.stream.IntStream=var873, $r2=var3698, java.util.function.IntPredicate=var609, org.apache.dubbo.common.utils.StringUtils$lambda_isSplitCase_0__298=var2551, $r1=var3886, $z0=var2540}
;seq <java.lang.String: java.util.stream.IntStream chars()>;	<org.apache.dubbo.common.utils.StringUtils$lambda_isSplitCase_0__298: java.util.function.IntPredicate bootstrap$(char)>
;cnt {"<java.lang.String: java.util.stream.IntStream chars()>": 1,"<org.apache.dubbo.common.utils.StringUtils$lambda_isSplitCase_0__298: java.util.function.IntPredicate bootstrap$(char)>": 1}
;stmts r0 := @parameter0: java.lang.String;	c0 := @parameter1: char;	if r0 != null goto $r2 = virtualinvoke r0.<java.lang.String: java.util.stream.IntStream chars()>();	$r2 = virtualinvoke r0.<java.lang.String: java.util.stream.IntStream chars()>();	$r1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils$lambda_isSplitCase_0__298: java.util.function.IntPredicate bootstrap$(char)>(c0);	$z0 = interfaceinvoke $r2.<java.util.stream.IntStream: boolean allMatch(java.util.function.IntPredicate)>($r1);	return $z0
;block_num 2