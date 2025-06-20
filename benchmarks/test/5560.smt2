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

(declare-sort var3823 0)
(declare-sort var1836 0)
(declare-sort var2408 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1836_isEmpty/-813097145 (String) Bool)
(declare-fun var1836_splitToList0/-1913919303 (String Int) var2408)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const var1831 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var1831 null-String)))
(declare-const var1992 Int) ; Statement: c0 := @parameter1: char 
(assert (not (= var1992 null-Int)))
(define-const var1677 Bool (var1836_isEmpty/-813097145 var1831)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0) 
 ; Statement: if $z0 == 0 goto $r1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.util.List splitToList0(java.lang.String,char)>(r0, c0) 
(assert (= (ite var1677 1 0) 0)) ; Cond: $z0 == 0 
(define-const var1848 var2408 (var1836_splitToList0/-1913919303 var1831 var1992)) ; Statement: $r1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.util.List splitToList0(java.lang.String,char)>(r0, c0) 
 ; Statement: return $r1 
(check-sat)
; {var1836_isEmpty/-813097145=([java.lang.String], boolean), var1836_splitToList0/-1913919303=([java.lang.String, char], java.util.List)}
; {var1831=r0, var3823=null_type, var1992=c0, var1836=org.apache.dubbo.common.utils.StringUtils, var1677=$z0, var2408=java.util.List, var1848=$r1}
; {r0=var1831, null_type=var3823, c0=var1992, org.apache.dubbo.common.utils.StringUtils=var1836, $z0=var1677, java.util.List=var2408, $r1=var1848}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>;	<org.apache.dubbo.common.utils.StringUtils: java.util.List splitToList0(java.lang.String,char)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1,"<org.apache.dubbo.common.utils.StringUtils: java.util.List splitToList0(java.lang.String,char)>": 1}
;stmts r0 := @parameter0: java.lang.String;	c0 := @parameter1: char;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0);	if $z0 == 0 goto $r1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.util.List splitToList0(java.lang.String,char)>(r0, c0);	$r1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.util.List splitToList0(java.lang.String,char)>(r0, c0);	return $r1
;block_num 2