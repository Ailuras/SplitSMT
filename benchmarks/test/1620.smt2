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

(declare-sort var2733 0)
(declare-sort var2154 0)
(declare-sort var1493 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun format/-1473966922 (var2733) var2154)
(declare-fun getInstanceOf/202174775 (var2154 String) var1493)
(declare-fun render/-1277379482 (var1493) String)
(declare-const null-var2733 var2733)
(declare-const var609 var2733) ; Statement: r0 := @this: org.antlr.v4.tool.ErrorManager 
(assert (not (= var609 null-var2733)))
(define-const var159 var2154 (format/-1473966922 var609)) ; Statement: $r1 = r0.<org.antlr.v4.tool.ErrorManager: org.stringtemplate.v4.STGroup format> 
(assert true)
(define-const var402 var1493 (getInstanceOf/202174775 var159 "wantsSingleLineMessage")) ; Statement: $r2 = virtualinvoke $r1.<org.stringtemplate.v4.STGroup: org.stringtemplate.v4.ST getInstanceOf(java.lang.String)>("wantsSingleLineMessage") 
(assert true)
(define-const var2586 String (render/-1277379482 var402)) ; Statement: $r3 = virtualinvoke $r2.<org.stringtemplate.v4.ST: java.lang.String render()>() 
(assert true)
(define-const var1796 Bool (= var2586 "true")) ; Statement: $z0 = virtualinvoke $r3.<java.lang.String: boolean equals(java.lang.Object)>("true") 
 ; Statement: return $z0 
(check-sat)
; {format/-1473966922=([org.antlr.v4.tool.ErrorManager], org.stringtemplate.v4.STGroup), getInstanceOf/202174775=([org.stringtemplate.v4.STGroup, java.lang.String], org.stringtemplate.v4.ST), render/-1277379482=([org.stringtemplate.v4.ST], java.lang.String)}
; {var2733=org.antlr.v4.tool.ErrorManager, var609=r0, var2154=org.stringtemplate.v4.STGroup, var159=$r1, var1493=org.stringtemplate.v4.ST, var402=$r2, var2586=$r3, var1796=$z0}
; {org.antlr.v4.tool.ErrorManager=var2733, r0=var609, org.stringtemplate.v4.STGroup=var2154, $r1=var159, org.stringtemplate.v4.ST=var1493, $r2=var402, $r3=var2586, $z0=var1796}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r0 := @this: org.antlr.v4.tool.ErrorManager;	$r1 = r0.<org.antlr.v4.tool.ErrorManager: org.stringtemplate.v4.STGroup format>;	$r2 = virtualinvoke $r1.<org.stringtemplate.v4.STGroup: org.stringtemplate.v4.ST getInstanceOf(java.lang.String)>("wantsSingleLineMessage");	$r3 = virtualinvoke $r2.<org.stringtemplate.v4.ST: java.lang.String render()>();	$z0 = virtualinvoke $r3.<java.lang.String: boolean equals(java.lang.Object)>("true");	return $z0
;block_num 1