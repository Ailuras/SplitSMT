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

(declare-sort var1321 0)
(declare-sort var3280 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun arr-String-init () (Array Int String))
(declare-fun var3280_isAnyEmpty/296893969 ((Array Int String)) Bool)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const null-__Array__Int__String__ (Array Int String))
(declare-const var18 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var18 null-String)))
(declare-const var1208 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var1208 null-String)))
(declare-const var3460 String) ; Statement: r3 := @parameter2: java.lang.String 
(assert (not (= var3460 null-String)))
(declare-const var3396 Int) ; Statement: i2 := @parameter3: int 
(assert (not (= var3396 null-Int)))
(define-const var519 (Array Int String) arr-String-init) ; Statement: $r0 = newarray (java.lang.String)[2] 
(declare-const var519!1 (Array Int String))
(assert (not (= var519!1 null-__Array__Int__String__)))
(assert (= (select var519!1 0) var18)) ; Statement: $r0[0] = r1 
(declare-const var519!2 (Array Int String))
(assert (not (= var519!2 null-__Array__Int__String__)))
(assert (= (select var519!2 1) var1208)) ; Statement: $r0[1] = r2 
(define-const var961 Bool (var3280_isAnyEmpty/296893969 var519!2)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isAnyEmpty(java.lang.String[])>($r0) 
 ; Statement: if $z0 != 0 goto return r1 
(assert (not (= (ite var961 1 0) 0))) ; Cond: $z0 != 0 
 ; Statement: return r1 
(check-sat)
; {arr-String-init=([], java.lang.String[]), var3280_isAnyEmpty/296893969=([java.lang.String[]], boolean)}
; {var18=r1, var1321=null_type, var1208=r2, var3460=r3, var3396=i2, var519=$r0, var3280=org.apache.dubbo.common.utils.StringUtils, var961=$z0}
; {r1=var18, null_type=var1321, r2=var1208, r3=var3460, i2=var3396, $r0=var519, org.apache.dubbo.common.utils.StringUtils=var3280, $z0=var961}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isAnyEmpty(java.lang.String[])>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isAnyEmpty(java.lang.String[])>": 1}
;stmts r1 := @parameter0: java.lang.String;	r2 := @parameter1: java.lang.String;	r3 := @parameter2: java.lang.String;	i2 := @parameter3: int;	$r0 = newarray (java.lang.String)[2];	$r0[0] = r1;	$r0[1] = r2;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isAnyEmpty(java.lang.String[])>($r0);	if $z0 != 0 goto return r1;	return r1
;block_num 2