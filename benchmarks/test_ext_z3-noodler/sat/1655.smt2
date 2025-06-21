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

(declare-sort var1754 0)
(declare-sort var1424 0)
(declare-sort var1409 0)
(declare-sort var2585 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun lastIndexOf/-1292097097 (String Int) Int)
(define-fun substring/-1240304868 ((s String) (begin Int) (end Int)) String (str.substr s begin (- end begin)))
(declare-fun imports/1607023845 (var1754) var1409)
(declare-fun var1409_add/328494887 (var1409 var2585) Bool)
(declare-fun cast-from-String-to-var2585 (String) var2585)
(define-fun endsWith/985337093 ((s String) (suffix String)) Bool (str.suffixof suffix s))
(declare-const null-var1754 var1754)
(declare-const null-String String)
(declare-const var2626 var1754) ; Statement: r2 := @this: org.apache.dubbo.common.compiler.support.CtClassBuilder 
(assert (not (= var2626 null-var1754)))
(declare-const var671 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var671 null-String)))
(assert true)
(define-const var741 Int (lastIndexOf/-1292097097 var671 46)) ; Statement: i0 = virtualinvoke r0.<java.lang.String: int lastIndexOf(int)>(46) 
 ; Statement: if i0 <= 0 goto return 
(assert (not (<= var741 0))) ; Negate: Cond: i0 <= 0  
(assert (and true (and (>= 0 0) (>= (str.len var671) var741) (>= var741 0))))
(define-const var2746 String (substring/-1240304868 var671 0 var741)) ; Statement: r1 = virtualinvoke r0.<java.lang.String: java.lang.String substring(int,int)>(0, i0) 
(define-const var141 var1409 (imports/1607023845 var2626)) ; Statement: $r3 = r2.<org.apache.dubbo.common.compiler.support.CtClassBuilder: java.util.List imports> 
;(assert (var1409_add/328494887 var141 (cast-from-String-to-var2585 var2746))) ; Statement: interfaceinvoke $r3.<java.util.List: boolean add(java.lang.Object)>(r1) 

(declare-const var141!1 var1409)
(declare-const var2746!1 String)
(assert true)
(define-const var1732 Bool (endsWith/985337093 var671 ".*")) ; Statement: $z0 = virtualinvoke r0.<java.lang.String: boolean endsWith(java.lang.String)>(".*") 
 ; Statement: if $z0 != 0 goto return 
(assert (not (= (ite var1732 1 0) 0))) ; Cond: $z0 != 0 
 ; Statement: return 
(check-sat)
; {lastIndexOf/-1292097097=([java.lang.String, int], int), substring/-1240304868=([java.lang.String, int, int], java.lang.String), imports/1607023845=([org.apache.dubbo.common.compiler.support.CtClassBuilder], java.util.List), var1409_add/328494887=([java.util.List, java.lang.Object], boolean), cast-from-String-to-var2585=([java.lang.String], java.lang.Object), endsWith/985337093=([java.lang.String, java.lang.String], boolean)}
; {var1754=org.apache.dubbo.common.compiler.support.CtClassBuilder, var2626=r2, var671=r0, var1424=null_type, var741=i0, var2746=r1, var1409=java.util.List, var141=$r3, var2585=java.lang.Object, var1732=$z0}
; {org.apache.dubbo.common.compiler.support.CtClassBuilder=var1754, r2=var2626, r0=var671, null_type=var1424, i0=var741, r1=var2746, java.util.List=var1409, $r3=var141, java.lang.Object=var2585, $z0=var1732}
;seq <java.lang.String: int lastIndexOf(int)>;	<java.lang.String: java.lang.String substring(int,int)>;	<java.lang.String: boolean endsWith(java.lang.String)>
;cnt {"<java.lang.String: int lastIndexOf(int)>": 1,"<java.lang.String: java.lang.String substring(int,int)>": 1,"<java.lang.String: boolean endsWith(java.lang.String)>": 1}
;stmts r2 := @this: org.apache.dubbo.common.compiler.support.CtClassBuilder;	r0 := @parameter0: java.lang.String;	i0 = virtualinvoke r0.<java.lang.String: int lastIndexOf(int)>(46);	if i0 <= 0 goto return;	r1 = virtualinvoke r0.<java.lang.String: java.lang.String substring(int,int)>(0, i0);	$r3 = r2.<org.apache.dubbo.common.compiler.support.CtClassBuilder: java.util.List imports>;	interfaceinvoke $r3.<java.util.List: boolean add(java.lang.Object)>(r1);	$z0 = virtualinvoke r0.<java.lang.String: boolean endsWith(java.lang.String)>(".*");	if $z0 != 0 goto return;	return
;block_num 3