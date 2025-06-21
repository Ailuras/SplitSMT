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

(declare-sort var298 0)
(declare-sort var3710 0)
(declare-sort var3927 0)
(declare-sort var3442 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3710_isEmpty/-813097145 (String) Bool)
(declare-fun var3710_tokenizeToList/-1645548398 (String (Array Int Int)) var3927)
(declare-fun var3927_toArray/-775711681 (var3927 (Array Int var3442)) (Array Int var3442))
(declare-fun cast-from-__Array__Int__String__-to-__Array__Int__var3442__ ((Array Int String)) (Array Int var3442))
(declare-fun cast-from-__Array__Int__var3442__-to-__Array__Int__String__ ((Array Int var3442)) (Array Int String))
(declare-const null-String String)
(declare-const null-__Array__Int__Int__ (Array Int Int))
(declare-const var3710-EMPTY_STRING_ARRAY (Array Int String))
(declare-const var2967 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var2967 null-String)))
(declare-const var2673 (Array Int Int)) ; Statement: r1 := @parameter1: char[] 
(assert (not (= var2673 null-__Array__Int__Int__)))
(define-const var3527 Bool (var3710_isEmpty/-813097145 var2967)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0) 
 ; Statement: if $z0 == 0 goto $r3 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.util.List tokenizeToList(java.lang.String,char[])>(r0, r1) 
(assert (= (ite var3527 1 0) 0)) ; Cond: $z0 == 0 
(define-const var643 var3927 (var3710_tokenizeToList/-1645548398 var2967 var2673)) ; Statement: $r3 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.util.List tokenizeToList(java.lang.String,char[])>(r0, r1) 
(define-const var2052 (Array Int String) var3710-EMPTY_STRING_ARRAY) ; Statement: $r2 = <org.apache.dubbo.common.utils.StringUtils: java.lang.String[] EMPTY_STRING_ARRAY> 
(define-const var3900 (Array Int var3442) (var3927_toArray/-775711681 var643 (cast-from-__Array__Int__String__-to-__Array__Int__var3442__ var2052))) ; Statement: $r4 = interfaceinvoke $r3.<java.util.List: java.lang.Object[] toArray(java.lang.Object[])>($r2) 
(define-const var2996 (Array Int String) (cast-from-__Array__Int__var3442__-to-__Array__Int__String__ var3900)) ; Statement: $r5 = (java.lang.String[]) $r4 
 ; Statement: return $r5 
(check-sat)
; {var3710_isEmpty/-813097145=([java.lang.String], boolean), var3710_tokenizeToList/-1645548398=([java.lang.String, char[]], java.util.List), var3927_toArray/-775711681=([java.util.List, java.lang.Object[]], java.lang.Object[]), cast-from-__Array__Int__String__-to-__Array__Int__var3442__=([java.lang.String[]], java.lang.Object[]), cast-from-__Array__Int__var3442__-to-__Array__Int__String__=([java.lang.Object[]], java.lang.String[])}
; {var2967=r0, var298=null_type, var2673=r1, var3710=org.apache.dubbo.common.utils.StringUtils, var3527=$z0, var3927=java.util.List, var643=$r3, var2052=$r2, var3442=java.lang.Object, var3900=$r4, var2996=$r5}
; {r0=var2967, null_type=var298, r1=var2673, org.apache.dubbo.common.utils.StringUtils=var3710, $z0=var3527, java.util.List=var3927, $r3=var643, $r2=var2052, java.lang.Object=var3442, $r4=var3900, $r5=var2996}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>;	<org.apache.dubbo.common.utils.StringUtils: java.util.List tokenizeToList(java.lang.String,char[])>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1,"<org.apache.dubbo.common.utils.StringUtils: java.util.List tokenizeToList(java.lang.String,char[])>": 1}
;stmts r0 := @parameter0: java.lang.String;	r1 := @parameter1: char[];	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0);	if $z0 == 0 goto $r3 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.util.List tokenizeToList(java.lang.String,char[])>(r0, r1);	$r3 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.util.List tokenizeToList(java.lang.String,char[])>(r0, r1);	$r2 = <org.apache.dubbo.common.utils.StringUtils: java.lang.String[] EMPTY_STRING_ARRAY>;	$r4 = interfaceinvoke $r3.<java.util.List: java.lang.Object[] toArray(java.lang.Object[])>($r2);	$r5 = (java.lang.String[]) $r4;	return $r5
;block_num 2