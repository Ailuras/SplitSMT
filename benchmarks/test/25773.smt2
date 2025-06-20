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

(declare-sort var3449 0)
(declare-sort var159 0)
(declare-sort var2649 0)
(declare-sort var1265 0)
(declare-sort var1853 0)
(declare-sort var1755 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun segments/617490631 (var3449) var1265)
(declare-fun var1853-init () var1853)
(declare-fun buf/617490631 (var3449) String)
(define-fun toString/-2075883882 ((s String)) String s)
(define-fun is-whitespace ((char String)) Bool (< (str.to_code char) 33))
(define-fun-rec trim-left ((s String)) String (ite (= s "") "" (ite (is-whitespace (str.substr s 0 1)) (trim-left (str.substr s 1 (- (str.len s) 1))) s)))
(define-fun-rec trim-right ((s String)) String (ite (= s "") "" (ite (is-whitespace (str.substr s (- (str.len s) 1) 1)) (trim-right (str.substr s 0 (- (str.len s) 1))) s)))
(define-fun trim/-847153721 ((s String)) String (trim-right (trim-left s)))
(declare-fun <init>/1940723953 (var1853 var159 String String) void)
(declare-fun var1265_add/328494887 (var1265 var1755) Bool)
(declare-fun cast-from-var1853-to-var1755 (var1853) var1755)
(declare-fun setLength/1276735992 (String Int) void)
(declare-const null-var3449 var3449)
(declare-const null-var159 var159)
(declare-const null-String String)
(declare-const var3636 var3449) ; Statement: r0 := @this: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathParser 
(assert (not (= var3636 null-var3449)))
(declare-const var2180 var159) ; Statement: r2 := @parameter0: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathSegment$Type 
(assert (not (= var2180 null-var159)))
(declare-const var388 String) ; Statement: r6 := @parameter1: java.lang.String 
(assert (not (= var388 null-String)))
(define-const var3236 var1265 (segments/617490631 var3636)) ; Statement: $r4 = r0.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathParser: java.util.List segments> 
(define-const var963 var1853 var1853-init) ; Statement: $r1 = new org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathSegment 
(define-const var932 String (buf/617490631 var3636)) ; Statement: $r3 = r0.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathParser: java.lang.StringBuilder buf> 
(assert true)
(define-const var1105 String (toString/-2075883882 var932)) ; Statement: $r5 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
(define-const var88 String (trim/-847153721 var1105)) ; Statement: $r8 = virtualinvoke $r5.<java.lang.String: java.lang.String trim()>() 
(assert true)
(define-const var967 String (trim/-847153721 var388)) ; Statement: $r7 = virtualinvoke r6.<java.lang.String: java.lang.String trim()>() 
(assert true)
;(assert (<init>/1940723953 var963 var2180 var88 var967)) ; Statement: specialinvoke $r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathSegment: void <init>(org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathSegment$Type,java.lang.String,java.lang.String)>(r2, $r8, $r7) 

(declare-const var963!1 var1853)
(declare-const var2180!1 var159)
(declare-const var88!1 String)
(declare-const var967!1 String)
;(assert (var1265_add/328494887 var3236 (cast-from-var1853-to-var1755 var963!1))) ; Statement: interfaceinvoke $r4.<java.util.List: boolean add(java.lang.Object)>($r1) 

(declare-const var3236!1 var1265)
(declare-const var963!2 var1853)
(define-const var1966 String (buf/617490631 var3636)) ; Statement: $r9 = r0.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathParser: java.lang.StringBuilder buf> 
(assert true)
;(assert (setLength/1276735992 var1966 0)) ; Statement: virtualinvoke $r9.<java.lang.StringBuilder: void setLength(int)>(0) 

(declare-const var1966!1 String)
(declare-const var3424 Int)
 ; Statement: return 
(check-sat)
; {segments/617490631=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathParser], java.util.List), var1853-init=([], org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathSegment), buf/617490631=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathParser], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), trim/-847153721=([java.lang.String], java.lang.String), <init>/1940723953=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathSegment, org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathSegment$Type, java.lang.String, java.lang.String], void), var1265_add/328494887=([java.util.List, java.lang.Object], boolean), cast-from-var1853-to-var1755=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathSegment], java.lang.Object), setLength/1276735992=([java.lang.StringBuilder, int], void)}
; {var3449=org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathParser, var3636=r0, var159=org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathSegment$Type, var2180=r2, var388=r6, var2649=null_type, var1265=java.util.List, var3236=$r4, var1853=org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathSegment, var963=$r1, var932=$r3, var1105=$r5, var88=$r8, var967=$r7, var1755=java.lang.Object, var1966=$r9, var3424=0}
; {org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathParser=var3449, r0=var3636, org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathSegment$Type=var159, r2=var2180, r6=var388, null_type=var2649, java.util.List=var1265, $r4=var3236, org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathSegment=var1853, $r1=var963, $r3=var932, $r5=var1105, $r8=var88, $r7=var967, java.lang.Object=var1755, $r9=var1966, 0=var3424}
;seq <java.lang.StringBuilder: java.lang.String toString()>;	<java.lang.String: java.lang.String trim()>;	<java.lang.String: java.lang.String trim()>;	<java.lang.StringBuilder: void setLength(int)>
;cnt {"<java.lang.StringBuilder: java.lang.String toString()>": 1,"<java.lang.String: java.lang.String trim()>": 2,"<java.lang.StringBuilder: void setLength(int)>": 1}
;stmts r0 := @this: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathParser;	r2 := @parameter0: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathSegment$Type;	r6 := @parameter1: java.lang.String;	$r4 = r0.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathParser: java.util.List segments>;	$r1 = new org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathSegment;	$r3 = r0.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathParser: java.lang.StringBuilder buf>;	$r5 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.String toString()>();	$r8 = virtualinvoke $r5.<java.lang.String: java.lang.String trim()>();	$r7 = virtualinvoke r6.<java.lang.String: java.lang.String trim()>();	specialinvoke $r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathSegment: void <init>(org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathSegment$Type,java.lang.String,java.lang.String)>(r2, $r8, $r7);	interfaceinvoke $r4.<java.util.List: boolean add(java.lang.Object)>($r1);	$r9 = r0.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathParser: java.lang.StringBuilder buf>;	virtualinvoke $r9.<java.lang.StringBuilder: void setLength(int)>(0);	return
;block_num 1