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

(declare-sort var2067 0)
(declare-sort var387 0)
(declare-sort var730 0)
(declare-sort var2549 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var730_isBlank/-523695098 (String) Bool)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-fun var2067_put/1464166817 (var2067 var2549 var2549) var2549)
(declare-fun cast-from-String-to-var2549 (String) var2549)
(declare-const null-var2067 var2067)
(declare-const null-String String)
(declare-const var235 var2067) ; Statement: r0 := @parameter0: java.util.Map 
(assert (not (= var235 null-var2067)))
(declare-const var1647 String) ; Statement: r1 := @parameter1: java.lang.String 
(assert (not (= var1647 null-String)))
(declare-const var697 String) ; Statement: r2 := @parameter2: java.lang.String 
(assert (not (= var697 null-String)))
(define-const var3795 Bool (var730_isBlank/-523695098 (cast-from-String-to-String var1647))) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>(r1) 
 ; Statement: if $z0 != 0 goto interfaceinvoke r0.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>(r1, r2) 
(assert (not (= (ite var3795 1 0) 0))) ; Cond: $z0 != 0 
;(assert (var2067_put/1464166817 var235 (cast-from-String-to-var2549 var1647) (cast-from-String-to-var2549 var697))) ; Statement: interfaceinvoke r0.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>(r1, r2) 

(declare-const var235!1 var2067)
(declare-const var1647!1 String)
(declare-const var697!1 String)
 ; Statement: return 
(check-sat)
; {var730_isBlank/-523695098=([java.lang.CharSequence], boolean), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence), var2067_put/1464166817=([java.util.Map, java.lang.Object, java.lang.Object], java.lang.Object), cast-from-String-to-var2549=([java.lang.String], java.lang.Object)}
; {var2067=java.util.Map, var235=r0, var1647=r1, var387=null_type, var697=r2, var730=org.apache.dubbo.common.utils.StringUtils, var3795=$z0, var2549=java.lang.Object}
; {java.util.Map=var2067, r0=var235, r1=var1647, null_type=var387, r2=var697, org.apache.dubbo.common.utils.StringUtils=var730, $z0=var3795, java.lang.Object=var2549}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>": 1}
;stmts r0 := @parameter0: java.util.Map;	r1 := @parameter1: java.lang.String;	r2 := @parameter2: java.lang.String;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>(r1);	if $z0 != 0 goto interfaceinvoke r0.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>(r1, r2);	interfaceinvoke r0.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>(r1, r2);	return
;block_num 2