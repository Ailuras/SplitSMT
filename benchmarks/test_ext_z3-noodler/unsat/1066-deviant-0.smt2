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

(declare-sort var2523 0)
(declare-sort var3646 0)
(declare-sort var3426 0)
(declare-sort var1999 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun indexOf/-1037706067 ((s String) (c Int)) Int (str.indexof s (str.from_code c) 0))
(define-fun length/-134980193 ((s String)) Int (str.len s))
(define-fun substring/-1240304868 ((s String) (begin Int) (end Int)) String (str.substr s begin (- end begin)))
(declare-fun var1999_parseURLBody/46347189 (String String var3646) var3426)
(declare-const null-String String)
(declare-const null-var3646 var3646)
(declare-const var1168 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var1168 null-String)))
(define-const var3958 var3646 null-var3646) ; Statement: r3 = null 
(assert true)
(define-const var2599 Int (indexOf/-1037706067 var1168 63)) ; Statement: i1 = virtualinvoke r0.<java.lang.String: int indexOf(int)>(63) 
 ; Statement: if i1 < 0 goto i1 = virtualinvoke r0.<java.lang.String: int length()>() 
(assert (< var2599 0)) ; Cond: i1 < 0 
(assert true)
(define-const var2599!1 Int (length/-134980193 var1168)) ; Statement: i1 = virtualinvoke r0.<java.lang.String: int length()>() 
(assert true) ; Non Conditional
(assert (not (and true (and (>= 0 0) (>= (str.len var1168) var2599!1) (>= var2599!1 0)))))
(check-sat)
; {indexOf/-1037706067=([java.lang.String, int], int), length/-134980193=([java.lang.String], int), substring/-1240304868=([java.lang.String, int, int], java.lang.String), var1999_parseURLBody/46347189=([java.lang.String, java.lang.String, java.util.Map], org.apache.dubbo.common.URL)}
; {var1168=r0, var2523=null_type, var3646=java.util.Map, var3958=r3, var2599=i1, var1349=$r2, var3426=org.apache.dubbo.common.URL, var1999=org.apache.dubbo.common.URLStrParser, var2706=$r1}
; {r0=var1168, null_type=var2523, java.util.Map=var3646, r3=var3958, i1=var2599, $r2=var1349, org.apache.dubbo.common.URL=var3426, org.apache.dubbo.common.URLStrParser=var1999, $r1=var2706}
;seq <java.lang.String: int indexOf(int)>;	<java.lang.String: int length()>;	<java.lang.String: java.lang.String substring(int,int)>
;cnt {"<java.lang.String: int indexOf(int)>": 1,"<java.lang.String: int length()>": 1,"<java.lang.String: java.lang.String substring(int,int)>": 1}
;stmts r0 := @parameter0: java.lang.String;	r3 = null;	i1 = virtualinvoke r0.<java.lang.String: int indexOf(int)>(63);	if i1 < 0 goto i1 = virtualinvoke r0.<java.lang.String: int length()>();	i1 = virtualinvoke r0.<java.lang.String: int length()>();	$r2 = virtualinvoke r0.<java.lang.String: java.lang.String substring(int,int)>(0, i1);	$r1 = staticinvoke <org.apache.dubbo.common.URLStrParser: org.apache.dubbo.common.URL parseURLBody(java.lang.String,java.lang.String,java.util.Map)>(r0, $r2, r3);	return $r1
;block_num 3