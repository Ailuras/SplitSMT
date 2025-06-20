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

(declare-sort var2802 0)
(declare-sort var1937 0)
(declare-sort var3554 0)
(declare-sort var1123 0)
(declare-sort var507 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3554_splitToList/858263979 (String Int) var1937)
(declare-fun var1937_size/-959786421 (var1937) Int)
(declare-fun var507_emptySet/2131139019 () var1123)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const null-Bool Bool)
(declare-const var3896 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var3896 null-String)))
(declare-const var399 Int) ; Statement: c0 := @parameter1: char 
(assert (not (= var399 null-Int)))
(declare-const var3823 Bool) ; Statement: z0 := @parameter2: boolean 
(assert (not (= var3823 null-Bool)))
(define-const var3859 var1937 (var3554_splitToList/858263979 var3896 var399)) ; Statement: r1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.util.List splitToList(java.lang.String,char)>(r0, c0) 
(define-const var247 Int (var1937_size/-959786421 var3859)) ; Statement: i1 = interfaceinvoke r1.<java.util.List: int size()>() 
 ; Statement: if i1 >= 1 goto (branch) 
(assert (not (>= var247 1))) ; Negate: Cond: i1 >= 1  
(define-const var3093 var1123 var507_emptySet/2131139019) ; Statement: $r12 = staticinvoke <java.util.Collections: java.util.Set emptySet()>() 
 ; Statement: return $r12 
(check-sat)
; {var3554_splitToList/858263979=([java.lang.String, char], java.util.List), var1937_size/-959786421=([java.util.List], int), var507_emptySet/2131139019=([], java.util.Set)}
; {var3896=r0, var2802=null_type, var399=c0, var3823=z0, var1937=java.util.List, var3554=org.apache.dubbo.common.utils.StringUtils, var3859=r1, var247=i1, var1123=java.util.Set, var507=java.util.Collections, var3093=$r12}
; {r0=var3896, null_type=var2802, c0=var399, z0=var3823, java.util.List=var1937, org.apache.dubbo.common.utils.StringUtils=var3554, r1=var3859, i1=var247, java.util.Set=var1123, java.util.Collections=var507, $r12=var3093}
;seq <org.apache.dubbo.common.utils.StringUtils: java.util.List splitToList(java.lang.String,char)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: java.util.List splitToList(java.lang.String,char)>": 1}
;stmts r0 := @parameter0: java.lang.String;	c0 := @parameter1: char;	z0 := @parameter2: boolean;	r1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.util.List splitToList(java.lang.String,char)>(r0, c0);	i1 = interfaceinvoke r1.<java.util.List: int size()>();	if i1 >= 1 goto (branch);	$r12 = staticinvoke <java.util.Collections: java.util.Set emptySet()>();	return $r12
;block_num 2