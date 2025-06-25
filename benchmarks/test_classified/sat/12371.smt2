(set-option :produce-unsat-cores true) ; enable generation of unsat cores
(set-option :produce-models true) ; enable model generation
(set-logic ALL)

(define-fun get_split_length ((x String) (d String) (limit Int)) Int
  (ite
    (> limit 0)
    (ite (< (str.num_splits x d) limit)
         (str.num_splits x d)
         limit)
    (str.num_splits x d)
  )
)

(define-fun get_split_element ((x String) (d String) (limit Int) (i Int)) String
  (ite
    (and (> limit 0)
         (= i (- limit 1))
         (>= (str.num_splits x d) limit))
    (str.split_rest x d (- limit 1))
    (str.split_at x d i)
  )
)

(declare-sort var3661 0)
(declare-sort var779 0)
(declare-sort var429 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var429-init () var429)
(declare-fun var3661_uri/805623633 (var3661) String)
(declare-fun <init>/304312615 (var429 String) void)
(declare-fun path/-2097338240 (var429) String)
(declare-const null-var3661 var3661)
(declare-const null-var779 var779)
(declare-const var1689 var3661) ; Statement: r0 := @parameter0: io.netty.handler.codec.http.HttpRequest 
(assert (not (= var1689 null-var3661)))
(define-const var2521 var779 null-var779) ; Statement: r34 = null 
 ; Statement: if r0 == null goto return r34 
(assert (not (= var1689 null-var3661))) ; Negate: Cond: r0 == null  
(define-const var916 var429 var429-init) ; Statement: $r1 = new io.netty.handler.codec.http.QueryStringDecoder 
(define-const var543 String (var3661_uri/805623633 var1689)) ; Statement: $r2 = interfaceinvoke r0.<io.netty.handler.codec.http.HttpRequest: java.lang.String uri()>() 
(assert true)
;(assert (<init>/304312615 var916 var543)) ; Statement: specialinvoke $r1.<io.netty.handler.codec.http.QueryStringDecoder: void <init>(java.lang.String)>($r2) 

(declare-const var916!1 var429)
(declare-const var543!1 String)
(assert true)
(define-const var738 String (path/-2097338240 var916!1)) ; Statement: r3 = virtualinvoke $r1.<io.netty.handler.codec.http.QueryStringDecoder: java.lang.String path()>() 
; split operation: var3338 = var738.split("/") ; Statement: r4 = virtualinvoke r3.<java.lang.String: java.lang.String[] split(java.lang.String)>("/") 
(define-const var2822 Int (get_split_length var738 "/" -1)) ; Statement: $i0 = lengthof r4 
 ; Statement: if $i0 != 2 goto $i1 = lengthof r4 
(assert (not (= var2822 2))) ; Cond: $i0 != 2 
(define-const var1562 Int (get_split_length var738 "/" -1)) ; Statement: $i1 = lengthof r4 
 ; Statement: if $i1 != 3 goto return r34 
(assert (not (= var1562 3))) ; Cond: $i1 != 3 
 ; Statement: return r34 
(check-sat)
; {var429-init=([], io.netty.handler.codec.http.QueryStringDecoder), var3661_uri/805623633=([io.netty.handler.codec.http.HttpRequest], java.lang.String), <init>/304312615=([io.netty.handler.codec.http.QueryStringDecoder, java.lang.String], void), path/-2097338240=([io.netty.handler.codec.http.QueryStringDecoder], java.lang.String)}
; {var3661=io.netty.handler.codec.http.HttpRequest, var1689=r0, var779=org.apache.dubbo.qos.api.CommandContext, var2521=r34, var429=io.netty.handler.codec.http.QueryStringDecoder, var916=$r1, var543=$r2, var738=r3, var3338=r4, var2822=$i0, var1562=$i1}
; {io.netty.handler.codec.http.HttpRequest=var3661, r0=var1689, org.apache.dubbo.qos.api.CommandContext=var779, r34=var2521, io.netty.handler.codec.http.QueryStringDecoder=var429, $r1=var916, $r2=var543, r3=var738, r4=var3338, $i0=var2822, $i1=var1562}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r0 := @parameter0: io.netty.handler.codec.http.HttpRequest;	r34 = null;	if r0 == null goto return r34;	$r1 = new io.netty.handler.codec.http.QueryStringDecoder;	$r2 = interfaceinvoke r0.<io.netty.handler.codec.http.HttpRequest: java.lang.String uri()>();	specialinvoke $r1.<io.netty.handler.codec.http.QueryStringDecoder: void <init>(java.lang.String)>($r2);	r3 = virtualinvoke $r1.<io.netty.handler.codec.http.QueryStringDecoder: java.lang.String path()>();	r4 = virtualinvoke r3.<java.lang.String: java.lang.String[] split(java.lang.String)>("/");	$i0 = lengthof r4;	if $i0 != 2 goto $i1 = lengthof r4;	$i1 = lengthof r4;	if $i1 != 3 goto return r34;	return r34
;block_num 4