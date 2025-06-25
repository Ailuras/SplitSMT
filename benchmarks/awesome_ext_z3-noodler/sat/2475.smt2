(set-option :produce-unsat-cores true) ; enable generation of unsat cores
(set-option :produce-models true) ; enable model generation
(set-logic ALL)

(define-fun get_split_length ((x String) (d String) (limit Int)) Int
  (ite
    (> limit 0)
    (ite (< (str.num_splits x d) limit)
         (str.num_splits x d)
         limit)
    (str.num_splits x d)
  )
)

(define-fun get_split_element ((x String) (d String) (limit Int) (i Int)) String
  (ite
    (and (> limit 0)
         (= i (- limit 1))
         (>= (str.num_splits x d) limit))
    (str.split_rest x d (- limit 1))
    (str.split_at x d i)
  )
)

(declare-sort var3878 0)
(declare-sort var2963 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun collector/108976718 (var3878) var2963)
(declare-fun debugInfoPresent/715258311 (var2963) Bool)
(declare-fun getResult/-2035574660 (var2963) String)
(declare-const null-var3878 var3878)
(declare-const null-var2963 var2963)
(declare-const var2812 var3878) ; Statement: r0 := @this: com.alibaba.fastjson2.internal.asm.TypeCollector 
(assert (not (= var2812 null-var3878)))
(define-const var1762 var2963 (collector/108976718 var2812)) ; Statement: $r1 = r0.<com.alibaba.fastjson2.internal.asm.TypeCollector: com.alibaba.fastjson2.internal.asm.MethodCollector collector> 
 ; Statement: if $r1 == null goto $r2 = newarray (java.lang.String)[0] 
(assert (not (= var1762 null-var2963))) ; Negate: Cond: $r1 == null  
(define-const var1662 var2963 (collector/108976718 var2812)) ; Statement: $r3 = r0.<com.alibaba.fastjson2.internal.asm.TypeCollector: com.alibaba.fastjson2.internal.asm.MethodCollector collector> 
(define-const var1931 Bool (debugInfoPresent/715258311 var1662)) ; Statement: $z0 = $r3.<com.alibaba.fastjson2.internal.asm.MethodCollector: boolean debugInfoPresent> 
 ; Statement: if $z0 != 0 goto $r4 = r0.<com.alibaba.fastjson2.internal.asm.TypeCollector: com.alibaba.fastjson2.internal.asm.MethodCollector collector> 
(assert (not (= (ite var1931 1 0) 0))) ; Cond: $z0 != 0 
(define-const var2386 var2963 (collector/108976718 var2812)) ; Statement: $r4 = r0.<com.alibaba.fastjson2.internal.asm.TypeCollector: com.alibaba.fastjson2.internal.asm.MethodCollector collector> 
(assert true)
(define-const var1849 String (getResult/-2035574660 var2386)) ; Statement: $r5 = virtualinvoke $r4.<com.alibaba.fastjson2.internal.asm.MethodCollector: java.lang.String getResult()>() 
; split operation: var2615 = var1849.split(",") ; Statement: $r6 = virtualinvoke $r5.<java.lang.String: java.lang.String[] split(java.lang.String)>(",") 
 ; Statement: return $r6 
(check-sat)
; {collector/108976718=([com.alibaba.fastjson2.internal.asm.TypeCollector], com.alibaba.fastjson2.internal.asm.MethodCollector), debugInfoPresent/715258311=([com.alibaba.fastjson2.internal.asm.MethodCollector], boolean), getResult/-2035574660=([com.alibaba.fastjson2.internal.asm.MethodCollector], java.lang.String)}
; {var3878=com.alibaba.fastjson2.internal.asm.TypeCollector, var2812=r0, var2963=com.alibaba.fastjson2.internal.asm.MethodCollector, var1762=$r1, var1662=$r3, var1931=$z0, var2386=$r4, var1849=$r5, var2615=$r6}
; {com.alibaba.fastjson2.internal.asm.TypeCollector=var3878, r0=var2812, com.alibaba.fastjson2.internal.asm.MethodCollector=var2963, $r1=var1762, $r3=var1662, $z0=var1931, $r4=var2386, $r5=var1849, $r6=var2615}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r0 := @this: com.alibaba.fastjson2.internal.asm.TypeCollector;	$r1 = r0.<com.alibaba.fastjson2.internal.asm.TypeCollector: com.alibaba.fastjson2.internal.asm.MethodCollector collector>;	if $r1 == null goto $r2 = newarray (java.lang.String)[0];	$r3 = r0.<com.alibaba.fastjson2.internal.asm.TypeCollector: com.alibaba.fastjson2.internal.asm.MethodCollector collector>;	$z0 = $r3.<com.alibaba.fastjson2.internal.asm.MethodCollector: boolean debugInfoPresent>;	if $z0 != 0 goto $r4 = r0.<com.alibaba.fastjson2.internal.asm.TypeCollector: com.alibaba.fastjson2.internal.asm.MethodCollector collector>;	$r4 = r0.<com.alibaba.fastjson2.internal.asm.TypeCollector: com.alibaba.fastjson2.internal.asm.MethodCollector collector>;	$r5 = virtualinvoke $r4.<com.alibaba.fastjson2.internal.asm.MethodCollector: java.lang.String getResult()>();	$r6 = virtualinvoke $r5.<java.lang.String: java.lang.String[] split(java.lang.String)>(",");	return $r6
;block_num 3