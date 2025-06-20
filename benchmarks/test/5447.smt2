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

(declare-sort var2574 0)
(declare-sort var3099 0)
(declare-sort var2860 0)
(declare-sort var672 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun hashCode/-467973558 (String) Int)
(declare-fun Int_valueOf/-1371140006 (Int) Int)
(declare-fun var3099_get/1088891777 (var3099 var672) var672)
(declare-fun cast-from-Int-to-var672 (Int) var672)
(declare-fun cast-from-var672-to-__Array__Int__Int__ (var672) (Array Int Int))
(declare-const null-String String)
(declare-const var2860-DECODE_TABLE_MAP var3099)
(declare-const null-__Array__Int__Int__ (Array Int Int))
(declare-const var2638 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var2638 null-String)))
(assert true)
(define-const var2466 Int (hashCode/-467973558 var2638)) ; Statement: i0 = virtualinvoke r0.<java.lang.String: int hashCode()>() 
(define-const var3318 var3099 var2860-DECODE_TABLE_MAP) ; Statement: $r1 = <org.apache.dubbo.common.io.Bytes: java.util.Map DECODE_TABLE_MAP> 
(define-const var3895 Int (Int_valueOf/-1371140006 var2466)) ; Statement: $r2 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>(i0) 
(define-const var3561 var672 (var3099_get/1088891777 var3318 (cast-from-Int-to-var672 var3895))) ; Statement: $r3 = interfaceinvoke $r1.<java.util.Map: java.lang.Object get(java.lang.Object)>($r2) 
(define-const var1238 (Array Int Int) (cast-from-var672-to-__Array__Int__Int__ var3561)) ; Statement: r7 = (byte[]) $r3 
 ; Statement: if r7 != null goto return r7 
(assert (not (= var1238 null-__Array__Int__Int__))) ; Cond: r7 != null 
 ; Statement: return r7 
(check-sat)
; {hashCode/-467973558=([java.lang.String], int), Int_valueOf/-1371140006=([int], java.lang.Integer), var3099_get/1088891777=([java.util.Map, java.lang.Object], java.lang.Object), cast-from-Int-to-var672=([java.lang.Integer], java.lang.Object), cast-from-var672-to-__Array__Int__Int__=([java.lang.Object], byte[])}
; {var2638=r0, var2574=null_type, var2466=i0, var3099=java.util.Map, var2860=org.apache.dubbo.common.io.Bytes, var3318=$r1, var3895=$r2, var672=java.lang.Object, var3561=$r3, var1238=r7}
; {r0=var2638, null_type=var2574, i0=var2466, java.util.Map=var3099, org.apache.dubbo.common.io.Bytes=var2860, $r1=var3318, $r2=var3895, java.lang.Object=var672, $r3=var3561, r7=var1238}
;seq <java.lang.String: int hashCode()>
;cnt {"<java.lang.String: int hashCode()>": 1}
;stmts r0 := @parameter0: java.lang.String;	i0 = virtualinvoke r0.<java.lang.String: int hashCode()>();	$r1 = <org.apache.dubbo.common.io.Bytes: java.util.Map DECODE_TABLE_MAP>;	$r2 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>(i0);	$r3 = interfaceinvoke $r1.<java.util.Map: java.lang.Object get(java.lang.Object)>($r2);	r7 = (byte[]) $r3;	if r7 != null goto return r7;	return r7
;block_num 2